`ifndef APB_SLAVE_MONITOR_PROXY_INCLUDED_
`define APB_SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: apb_slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class apb_slave_monitor_proxy extends uvm_monitor;
  
  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
//  import spi_globals_pkg::*;

  `uvm_component_utils(apb_slave_monitor_proxy)
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(apb_slave_tx) apb_slave_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm slave_mon_bfm_h;
    
  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

  endclass : apb_slave_monitor_proxy
                                                          
//--------------------------------------------------------------------------------------------
//  Construct: new
//  Parameters:
//  name - apb_slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_monitor_proxy::new(string name = "apb_slave_monitor_proxy",
                                                       uvm_component parent = null);
  super.new(name, parent);

 apb_slave_analysis_port = new("apb_slave_analysis_port",this);

endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  //if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",
    //                                                          slave_mon_bfm_h)) begin
     //`uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in 
     //                                                    apb_slave_monitor_proxy"));  
  //end 
  //slave_analysis_port = new("slave_analysis_port",this);

  // MSHA: if(!uvm_config_db#(apb_slave_agent_config)::get(this,"","apb_slave_agent_config",
    //                                                            apb_slave_agent_cfg_h)) begin
  // MSHA:   `uvm_fatal("FATAL_S_AGENT_CFG",$sformatf("Couldn't get S_AGENT_CFG in 
  //                                                              apb_slave_monitor_proxy"));
  // MSHA: end

endfunction : build_phase

`endif
