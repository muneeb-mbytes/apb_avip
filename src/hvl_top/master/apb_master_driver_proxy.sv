`ifndef APB_MASTER_DRIVER_PROXY_INCLUDED_
`define APB_MASTER_DRIVER_PROXY_INCLUDED_
    
//--------------------------------------------------------------------------------------------
//  Class: apb_master_driver_proxy
//  Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
//  Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
//  uvm_driver is a parameterized class and it is parameterized with the type of the request 
//  sequence_item and the type of the response sequence_item 
//--------------------------------------------------------------------------------------------
class apb_master_driver_proxy extends uvm_driver #(apb_master_tx);
  `uvm_component_utils(apb_master_driver_proxy)
  
  //Variable : tx_h
  //Declaring handle for apb master transaction
  apb_master_tx apb_master_tx_h;
  
  //Variable : apb_master_drv_bfm_h
  //Declaring handle for apb driver bfm
  virtual apb_master_driver_bfm apb_master_drv_bfm_h;
   
  // Variable: apb_master_agent_cfg_h
  // Declaring handle for apb_master agent config class 
  apb_master_agent_config apb_master_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_driver_proxy", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
//  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  //extern virtual task drive_access_state(inout apb_transfer_char_s struct_packet, input apb_transfer_cfg_s struct_cfg);
  //extern virtual task drive_to_bfm();
endclass : apb_master_driver_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - apb_master_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_master_driver_proxy::new(string name = "apb_master_driver_proxy",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Creates the required ports, gets the required configuration from confif_db
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual apb_master_driver_bfm)::get(this,"","apb_master_driver_bfm",apb_master_drv_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_APB_MASTER_DRIVER_BFM","cannot get() apb_master_drv_bfm_h");
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connecting apb_master driver handle with apb_master agent config
//  
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  // apb_master_drv_bfm_h = apb_master_agent_cfg_h.apb_master_drv_bfm_h;
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
//  Function: end_of_elaboration_phase
//  Pointing handle of driver proxy in HDL BFM to this proxy method in HVL part
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  apb_master_drv_bfm_h.apb_master_drv_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void apb_master_driver_proxy::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
//  Task: run_phase
//  Gets the sequence_item, converts them to struct compatible transactions
// and sends them to the BFM to drive the data over the interface
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_master_driver_proxy::run_phase(uvm_phase phase);
  bit pselx,penable;

  super.run_phase(phase);
  //phase.raise_objection(this, "apb_master_driver_proxy");
  //`uvm_info(get_type_name(),$sformatf("APB_DRV_PROXY_1"),UVM_LOW);
  
  //wait for system reset
  apb_master_drv_bfm_h.wait_for_presetn();

  forever begin
    apb_transfer_char_s struct_packet;
    apb_transfer_cfg_s struct_cfg;

    seq_item_port.get_next_item(req);
  //`uvm_info(get_type_name(),$sformatf("APB_DRV_PROXY_2"),UVM_LOW);

  //Converting transaction to struct data_packet
  apb_master_seq_item_converter::from_class(req, struct_packet); 
  //Converting configurations to struct cfg_packet
  apb_master_cfg_converter::from_class(apb_master_agent_cfg_h, struct_cfg);


  apb_master_drv_bfm_h.drive_to_bfm(struct_packet,struct_cfg);
  
  
  //Drive the idel state for APB interface
  //apb_master_drv_bfm_h.drive_idle_state();

  //drive to setup state for APB interface
  //apb_master_drv_bfm_h.drive_setup_state();
  

  apb_master_seq_item_converter::to_class(struct_packet, req);
  seq_item_port.item_done();

  end
endtask : run_phase

//-------------------------------------------------------
//Task: drive to bfm
//This task converts the transaction data packet to struct type 
//and send it to the master driver bfm
//-------------------------------------------------------
//task apb_master_driver_proxy::drive_to_bfm(inout apb_transfer_char_s packet,
//                                           input abp_transfer_cfg_s  packet1);
//  apb_master_drv_bfm_h.drive_access_state(packet,packet1);
//  `uvm_info(get_type_name(),$sformatf("after struct packet: , \n %p",packet1),UVM_LOW);
//endtask:drive_to_bfm

`endif

