`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;
  
  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
//  import spi_globals_pkg::*;

  `uvm_component_utils(slave_monitor_proxy)
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(slave_tx) slave_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm slave_mon_bfm_h;
    
  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

  endclass : slave_monitor_proxy
                                                          
//--------------------------------------------------------------------------------------------
//  Construct: new
//  Parameters:
//  name - slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",uvm_component parent = null);
  super.new(name, parent);

 slave_analysis_port = new("slave_analysis_port",this);

endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  //if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",slave_mon_bfm_h)) begin
     //`uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in Slave_Monitor_proxy"));  
  //end 
  //slave_analysis_port = new("slave_analysis_port",this);

  // MSHA: if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",slave_agent_cfg_h)) begin
  // MSHA:   `uvm_fatal("FATAL_S_AGENT_CFG",$sformatf("Couldn't get S_AGENT_CFG in Slave_Monitor_proxy"));
  // MSHA: end

endfunction : build_phase

`endif
