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
  extern virtual task check_for_pslverr(inout apb_transfer_char_s struct_packet);
  extern virtual task task_write(inout apb_transfer_char_s struct_packet);
  extern virtual task task_read(inout apb_transfer_char_s struct_packet);
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
    `uvm_info("DEBUG_MSHA", $sformatf("AFTER WAIT FOR SETUP STATE- STRUCT :: %p", struct_packet), UVM_HIGH); 
  
    // TODO(mshariff): access the slave memory 
    check_for_pslverr(struct_packet);
    `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_5 -struct:: %p", struct_packet), UVM_MEDIUM); 
    
    seq_item_port.get_next_item(req);
    //Printing the req item
    `uvm_info(get_type_name(), $sformatf("REQ-SLAVE_TX \n %s",req.sprint),UVM_LOW);
      
    // TODO(mshariff): 
    // Put the data from struct_packet and req into req using choose_packet_data variable
    if(req.choose_packet_data) begin

      //Printing the req item
      //`uvm_info(get_type_name(), $sformatf("REQ-SLAVE_TX \n %s",req.sprint),UVM_LOW);
  
      //Converting transaction to struct data_packet
      apb_slave_seq_item_converter::from_class(req, struct_packet); 

      //Converting configurations to struct cfg_packet
      apb_slave_cfg_converter::from_class(apb_slave_agent_cfg_h, struct_cfg);

      `uvm_info("DEBUG_NA", $sformatf("before wait for access state- struct :: %p", struct_packet), UVM_HIGH); 
      
      //drive the converted data packets to the slave driver bfm
      apb_slave_drv_bfm_h.wait_for_access_state(struct_packet);
  
      //converting the struct data items into transcations 
      apb_slave_seq_item_converter::to_class(struct_packet, req);

    end
    else begin

      `uvm_info("DEBUG_NA", $sformatf("before wait for access state- inside else :: %p", struct_packet), UVM_HIGH); 
      `uvm_info("DEBUG_NA", $sformatf("before wait for access state- inside else prdata :: %0h", struct_packet.prdata), UVM_HIGH); 
       
      //drive the converted data packets to the slave driver bfm
      apb_slave_drv_bfm_h.wait_for_access_state(struct_packet);

      //`uvm_info("DEBUG_NA", $sformatf("before wait for access state- inside else :: %p", struct_packet), UVM_HIGH); 
    end
  
    seq_item_port.item_done();

  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: task_write
// This task is used to write the data into the slave memory
// Parameters:
//  struct_packet   - apb_transfer_char_s
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::task_write(inout apb_transfer_char_s struct_packet);
  
  `uvm_info("DEBUG_NA", $sformatf("task_write"), UVM_HIGH); 
  for(int i=0; i<(DATA_WIDTH/8); i++)begin
    `uvm_info("DEBUG_NA", $sformatf("task_write inside for loop :: %0d", i), UVM_HIGH);
    `uvm_info("DEBUG_NA", $sformatf("task_write inside for loop pstrb = %0b", struct_packet.pstrb[i]), UVM_HIGH);
    if(struct_packet.pstrb[i] == 1)begin
      apb_slave_agent_cfg_h.slave_memory_task(struct_packet.paddr+i,struct_packet.pwdata[8*i+7 -: 8]);
      `uvm_info("DEBUG_NA", $sformatf("task_write inside for loop data = %0h", 
                                      apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr+i]), UVM_HIGH);
    end
  end

endtask : task_write

//--------------------------------------------------------------------------------------------
// Task: task_read
// This task is used to read the data from the slave memory
// Parameters:
//  struct_packet   - apb_transfer_char_s
//--------------------------------------------------------------------------------------------
task apb_slave_driver_proxy::task_read(inout apb_transfer_char_s struct_packet);
  
  bit [7:0]local_rdata;

  `uvm_info("DEBUG_NA", $sformatf("task_read"), UVM_HIGH);
  for(int i=0; i<(DATA_WIDTH/8); i++)begin
    if(apb_slave_agent_cfg_h.slave_memory.exists(struct_packet.paddr))begin
      struct_packet.prdata[8*i+7 -: 8] = apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr + i];
    end
    else begin
      `uvm_error(get_type_name(), $sformatf("Selected address has no data"));
      struct_packet.pslverr = ERROR;
      struct_packet.prdata  = 'h0;
    end
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
task apb_slave_driver_proxy::check_for_pslverr(inout apb_transfer_char_s struct_packet);

  `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_1 struct :: %p", struct_packet), UVM_HIGH);
  if(struct_packet.paddr inside {[apb_slave_agent_cfg_h.min_address : apb_slave_agent_cfg_h.max_address]}) begin
    struct_packet.pslverr = NO_ERROR;
   
    if(struct_packet.pwrite == WRITE)begin
      task_write(struct_packet);
    end
    else begin
      task_read(struct_packet);
    end
  
  end
  else begin 
    struct_packet.pslverr = ERROR;
    struct_packet.prdata  = 'h0;
  end
  `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_2 min_address = %0h, max_address=%0h ",
                                  apb_slave_agent_cfg_h.min_address, apb_slave_agent_cfg_h.max_address), UVM_HIGH);

  `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_3 struct-paddr :: %0h", struct_packet.paddr), UVM_HIGH);
  `uvm_info("DEBUG_NA-pslverr", $sformatf("AFTER PSLVERR_CHECK_4 struct :: %p", struct_packet), UVM_HIGH);

  for(int i=0; i<4; i++) begin
    `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_4A inside for loop :: %0d", i), UVM_HIGH);
    if(apb_slave_agent_cfg_h.slave_memory.exists(struct_packet.paddr+i)) begin
      `uvm_info("DEBUG_NA", $sformatf("AFTER PSLVERR_CHECK_4B memory[%0h]=%0h ",struct_packet.paddr,
                                      apb_slave_agent_cfg_h.slave_memory[struct_packet.paddr+i]), UVM_HIGH);
    end

  //Adding dummy data to check whether read is working or not
  //struct_packet.prdata = 32'hDEADBEEF;
  `uvm_info("DEBUG_NA-pslverr", $sformatf("AFTER PSLVERR_CHECK_4C struct :: %p", struct_packet), UVM_MEDIUM);
  end

endtask : check_for_pslverr 

`endif
