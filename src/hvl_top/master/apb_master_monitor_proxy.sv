`ifndef APB_MASTER_MONITOR_PROXY_INCLUDED_
`define APB_MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_master_monitor_proxy
//  Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
//  A monitor is a passive entity that samples the DUT signals through virtual interface and 
//  converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
//  Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class apb_master_monitor_proxy extends uvm_component; 
  `uvm_component_utils(apb_master_monitor_proxy)
  
  //Variable : apb_master_mon_bfm_h
  //Declaring handle for apb monitor bfm
  virtual apb_master_monitor_bfm apb_master_mon_bfm_h;
   
  // Variable: apb_master_agent_cfg_h
  // Declaring handle for apb_master agent config class 
  apb_master_agent_config apb_master_agent_cfg_h;
    
  // Variable: apb_master_analysis_port
  //declaring analysis port for the monitor port
  uvm_analysis_port#(apb_master_tx) apb_master_analysis_port;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_monitor_proxy", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
//  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_master_monitor_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object

//  Parameters:
//  name - apb_master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_master_monitor_proxy::new(string name = "apb_master_monitor_proxy",uvm_component parent);
  super.new(name, parent);
  apb_master_analysis_port = new("apb_master_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Creates the required ports, gets the required configuration from confif_db
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual apb_master_monitor_bfm)::get(this,"","apb_master_monitor_bfm",apb_master_mon_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_APB_MASTER_MONITOR_BFM","cannot get() apb_master_mon_bfm_h");
  end 
  
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connecting apb_master monitor handle with apb_master agent config
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  // apb_master_mon_bfm_h = apb_master_agent_cfg_h.apb_master_mon_bfm_h;
endfunction : connect_phase


//--------------------------------------------------------------------------------------------
//  Function: end_of_elaboration_phase
//  Pointing handle of monitor proxy in HDL BFM to this proxy method in HVL part
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  apb_master_mon_bfm_h.apb_master_mon_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void apb_master_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
//  Task: run_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_master_monitor_proxy::run_phase(uvm_phase phase);


  super.run_phase(phase);

  // ...


endtask : run_phase

`endif

