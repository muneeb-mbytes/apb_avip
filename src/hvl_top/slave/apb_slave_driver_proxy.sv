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
  apb_slave_drv_bfm_h.wait_for_presetn();
  forever begin
    apb_transfer_char_s struct_packet;
    apb_transfer_cfg_s struct_cfg;

    seq_item_port.get_next_item(req);

    //Printing the req item
    //req.print();
    `uvm_info(get_type_name(), $sformatf("REQ-SLAVE_TX \n %s",req.sprint),UVM_LOW);
  
    //Printing master agent config
    `uvm_info(get_type_name(),$sformatf("\n apb_slave_agent_config\n%s",apb_slave_agent_cfg_h.sprint),UVM_LOW);

    //Converting transaction to struct data_packet
    apb_slave_seq_item_converter::from_class(req, struct_packet); 

    //Converting configurations to struct cfg_packet
    apb_slave_cfg_converter::from_class(apb_slave_agent_cfg_h, struct_cfg);

    //drive the converted data packets to the slave driver bfm
    apb_slave_drv_bfm_h.drive_to_bfm(struct_packet,struct_cfg);
  
  
    //Drive the idel state for APB interface
    //apb_slave_drv_bfm_h.drive_idle_state();

    //drive to setup state for APB interface
    //apb_slave_drv_bfm_h.drive_setup_state();
  
    //converting the struct data items into transcations 
    apb_slave_seq_item_converter::to_class(struct_packet, req);
    seq_item_port.item_done();
  end
  endtask : run_phase

`endif
