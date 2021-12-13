`ifndef APB_SLAVE_DRIVER_PROXY_INCLUDED_
`define APB_SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_slave_driver_proxy
//  This is the proxy driver on the HVL side
//  It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class apb_slave_driver_proxy extends uvm_driver#(apb_slave_tx);
  `uvm_component_utils(apb_slave_driver_proxy)

  //Variable : apb_slave_tx_h
  //Declaring handle for apb slave transaction
  apb_slave_tx apb_slave_tx_h;

  // Variable: apb_slave_driver_bfm_h;
  // Handle for apb_slave driver bfm
  virtual apb_slave_driver_bfm apb_slave_drv_bfm_h;

  // Variable: apb_slave_agent_cfg_h;
  // Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task check_for_pslverr(apb_transfer_char_s struct_packet);
  extern virtual task task_write(apb_transfer_char_s struct_packet);
  extern virtual task task_read(apb_transfer_char_s struct_packet);
endclass : apb_slave_driver_proxy
  
//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - apb_slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_driver_proxy::new(string name = "apb_slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Slave_driver_bfm congiguration is obtained in build phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual apb_slave_driver_bfm)::get(this,"","apb_slave_driver_bfm",
                                                             apb_slave_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_SLAVE_DRIVER_BFM","cannot get() apb_slave_drv_bfm_h");
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connects driver_proxy and driver_bfm
//
//  Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void apb_slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


//-------------------------------------------------------
// Function: end_of_elaboration_phase
//Description: connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//-------------------------------------------------------
function void apb_slave_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  apb_slave_drv_bfm_h.apb_slave_drv_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Gets the sequence_item, converts them to struct compatible transactions
// and sends them to the BFM to drive the data over the interface
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::run_phase(uvm_phase phase);
  
  //wait for system reset
  apb_slave_drv_bfm_h.wait_for_preset_n();

  forever begin
    apb_transfer_char_s struct_packet;
    apb_transfer_cfg_s struct_cfg;

    apb_slave_drv_bfm_h.wait_for_setup_state(struct_packet);
    `uvm_info("DEBUG_MSHA", $sformatf("AFTER wait struct :: %p", struct_packet), UVM_NONE); 
  
    check_for_pslverr(struct_packet);
    // TODO(mshariff): 
    // access the slave memory
    //for(int i=0; i<DATA_WIDTH/8; i++) begin
    //  bit [7:0] local_data;
    //  local_data = struct_packet.pwdata[8*i+];
    //  apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr] = local_data;
    //end
    apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr] = struct_packet.pwdata;

    //slave_memory_display
    `uvm_info(get_type_name(), $sformatf("SLAVE_ADDRESS[%0h]=%0d",struct_packet.paddr,apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr]),UVM_HIGH);

    seq_item_port.get_next_item(req);

    // TODO(mshariff): 
    // Put the data from struct_packet and req into req using choose_packet_data variable

    //Printing the req item
    `uvm_info(get_type_name(), $sformatf("REQ-SLAVE_TX \n %s",req.sprint),UVM_LOW);
  
    //Converting transaction to struct data_packet
    apb_slave_seq_item_converter::from_class(req, struct_packet); 

    //Converting configurations to struct cfg_packet
    apb_slave_cfg_converter::from_class(apb_slave_agent_cfg_h, struct_cfg);

    //`uvm_info(get_type_name(), $sformatf("Inside slave driver proxy-driver to bfm "),UVM_HIGH);
    //drive the converted data packets to the slave driver bfm
    apb_slave_drv_bfm_h.wait_for_access_state(struct_packet);
  
    //converting the struct data items into transcations 
    apb_slave_seq_item_converter::to_class(struct_packet, req);
  
    seq_item_port.item_done();

  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: task_write
// This task is used to write the data into the slave memory
// Parameters:
//  struct_packet   - apb_transfer_char_s
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::task_write(apb_transfer_char_s struct_packet);
  
  for(int i=0; i<(DATA_WIDTH/8); i++)begin
    if(struct_packet.pstrb[i] == 1)begin
      apb_slave_agent_cfg_h.slave_memory_task(struct_packet.paddr+i,struct_packet.pwdata[8*i+7 -: 8]);
    end
  end

endtask : task_write

//--------------------------------------------------------------------------------------------
// Task: task_read
// This task is used to read the data from the slave memory
// Parameters:
//  struct_packet   - apb_transfer_char_s
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::task_read(apb_transfer_char_s struct_packet);
  
  bit [7:0]local_rdata;
  //local [DATA_WIDTH-1:0]read_data;

  for(int i=0; i<(DATA_WIDTH/8); i++)begin
    //read_data = read_data >> 8;
    local_rdata = apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr + i];
    struct_packet.prdata[8*i+7 -: 8] = local_rdata;
  end 

endtask : task_read

//--------------------------------------------------------------------------------------------
// Task: check_for_pslverr
// Gets the struct packet and sends it to slave agent config to check the correct address 
// of the slave is selected
//
// Parameters:
//  struct_packet   - apb_transfer_char_s
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::check_for_pslverr(apb_transfer_char_s struct_packet);

  `uvm_info("PACKET_FROM_RUN_PHASE", $sformatf("AFTER wait struct :: %p", struct_packet), UVM_HIGH);
  if(struct_packet.paddr inside {[apb_slave_agent_cfg_h.min_address : apb_slave_agent_cfg_h.max_address]}) begin
    struct_packet.pslverr = NO_ERROR;
   
    if(struct_packet.pwrite == WRITE)begin
      task_write(struct_packet);
    end
    else begin
      task_read(struct_packet);
    end
    //case(struct_packet.pwrite)
    //  WRITE : task_write(apb_transfer_char_s struct_packet);
    //  READ  : task_read(apb_transfer_char_s struct_packet);
    //endcase
    
    //struct_packet.pwrite == WRITE ? task_write(apb_transfer_char_s struct_packet) : task_read(apb_transfer_char_s struct_packet);
    //foreach(apb_slave_agent_cfg_h.slave_memory[i])begin
      //`uvm_info("CHECK FROM PSLAVE ERROR", $sformatf("ADDRESS=%0h, DATA=%0h",struct_packet.paddr,apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr]), UVM_HIGH);
    //end
  end
  else begin 
    struct_packet.pslverr = ERROR;
  end
  `uvm_info("PACKET_FROM_RUN_PHASE", $sformatf("min_address = %0h, max_address=%0h ",apb_slave_agent_cfg_h.min_address, apb_slave_agent_cfg_h.max_address), UVM_HIGH);
  //struct_packet.pslverr = struct_packet.paddr inside {[apb_slave_agent_cfg_h.min_address : apb_slave_agent_cfg_h.max_address]} ? NO_ERROR : ERROR;

  `uvm_info("PACKET_FROM_RUN_PHASE", $sformatf("AFTER wait struct-paddr :: %0h", struct_packet.paddr), UVM_HIGH);
  `uvm_info("PACKET_FROM_RUN_PHASE-pslverr", $sformatf("AFTER wait struct :: %p", struct_packet), UVM_HIGH);
endtask : check_for_pslverr 

`endif
