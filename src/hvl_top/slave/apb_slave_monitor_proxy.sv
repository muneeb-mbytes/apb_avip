`ifndef APB_SLAVE_MONITOR_PROXY_INCLUDED_
`define APB_SLAVE_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_monitor_proxy
//  This is the HVL slave monitor proxy
//  It gets the sampled data from the HDL slave monitor and converts them into transaction items
//--------------------------------------------------------------------------------------------
class apb_slave_monitor_proxy extends uvm_monitor;
  
  `uvm_component_utils(apb_slave_monitor_proxy)

  //Variable: apb_slave_analysis_port
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(apb_slave_tx) apb_slave_analysis_port;
  
  //Variable: apb_slave_mon_bfm_h
  //Declaring Virtual Monitor BFM Handle
  virtual apb_slave_monitor_bfm apb_slave_mon_bfm_h;
    
  //Variable: apb_slave_agent_cfg_h;
  //Handle for apb slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_slave_monitor_proxy
                                                          
//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - apb_slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_monitor_proxy::new(string name = "apb_slave_monitor_proxy", uvm_component parent = null);
  super.new(name, parent);
  apb_slave_analysis_port = new("apb_slave_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Here we get the apb_slave_mon_bfm_h handle from the apb_slave_monitor_bfm BFM
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(virtual apb_slave_monitor_bfm)::get(this,"","apb_slave_monitor_bfm",apb_slave_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get SLAVE_MON_BFM_H in apb_slave_monitor_proxy"));  
  end 
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//  connects monitor_proxy and monitor_bfm
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void apb_slave_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  apb_slave_mon_bfm_h.apb_slave_mon_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Calls the tasks defined in slave monitor bfm 
//  Receives data packet from slave monitor bfm and converts into the transaction objects
// 
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_slave_monitor_proxy::run_phase(uvm_phase phase);
  apb_slave_tx apb_slave_packet;
  
  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW);
  apb_slave_packet = apb_slave_tx::type_id::create("slave_packet");
  
  apb_slave_mon_bfm_h.wait_for_preset_n();
  
  forever begin
    apb_transfer_char_s  struct_data_packet;
    apb_transfer_cfg_s   struct_cfg_packet; 
    apb_slave_tx         apb_slave_clone_packet;
    
    apb_slave_cfg_converter :: from_class (apb_slave_agent_cfg_h, struct_cfg_packet);
    apb_slave_mon_bfm_h.sample_data (struct_data_packet, struct_cfg_packet);
    apb_slave_seq_item_converter :: to_class(struct_data_packet, apb_slave_packet);

    `uvm_info(get_type_name(),$sformatf("Received packet from SLAVE_MONITOR_BFM: , \n %s", apb_slave_packet.sprint()),UVM_HIGH)

    // Clone and publish the cloned item to the subscribers
    $cast(apb_slave_clone_packet, apb_slave_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port: , \n %s", apb_slave_clone_packet.sprint()),UVM_HIGH)
    apb_slave_analysis_port.write(apb_slave_clone_packet);
  end

endtask : run_phase

`endif

