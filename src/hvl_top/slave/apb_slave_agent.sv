`ifndef APB_SLAVE_AGENT_INCLUDED_
`define APB_SLAVE_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_agent
//  This agent has sequencer, driver_proxy, monitor_proxy for APB  
//--------------------------------------------------------------------------------------------
class apb_slave_agent extends uvm_agent;
  `uvm_component_utils(apb_slave_agent)

  //Variable: apb_slave_agent_cfg_h;
  //Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //Variable: apb_slave_seqr_h;
  //Handle for apb slave sequencer
  apb_slave_sequencer apb_slave_seqr_h;

  //Variable: apb_slave_drv_proxy_h
  //Handle for apb slave driver proxy
  apb_slave_driver_proxy apb_slave_drv_proxy_h;

  //Variable: apb_slave_mon_proxy_h
  //Handle for apb slave monitor proxy
  apb_slave_monitor_proxy apb_slave_mon_proxy_h;

  //Variable: apb_slave_coverage
  //Decalring a handle for apb slave coverage
  apb_slave_coverage apb_slave_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_agent", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : apb_slave_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - instance name of the  apb_slave_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_agent::new(string name = "apb_slave_agent", uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void apb_slave_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(apb_slave_agent_cfg_h.is_active == UVM_ACTIVE) begin
    apb_slave_drv_proxy_h = apb_slave_driver_proxy::type_id::create("apb_slave_drv_proxy_h",this);
    apb_slave_seqr_h = apb_slave_sequencer::type_id::create("apb_slave_seqr_h",this);
  end

  apb_slave_mon_proxy_h = apb_slave_monitor_proxy::type_id::create("apb_slave_mon_proxy_h",this);

  if(apb_slave_agent_cfg_h.has_coverage) begin
    apb_slave_cov_h = apb_slave_coverage::type_id::create("apb_slave_cov_h",this);
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase 
//  It connects the components using TLM ports
//  
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_slave_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  if(apb_slave_agent_cfg_h.is_active == UVM_ACTIVE) begin
    apb_slave_drv_proxy_h.apb_slave_agent_cfg_h = apb_slave_agent_cfg_h;
    apb_slave_seqr_h.apb_slave_agent_cfg_h = apb_slave_agent_cfg_h;
    apb_slave_cov_h.apb_slave_agent_cfg_h = apb_slave_agent_cfg_h;
    
    //Connecting the ports
    apb_slave_drv_proxy_h.seq_item_port.connect(apb_slave_seqr_h.seq_item_export);
    //Connecting monitor_proxy port to coverage export
    apb_slave_mon_proxy_h.apb_slave_analysis_port.connect(apb_slave_cov_h.analysis_export);
  end

  //Passing the slave agent config to the slave driver proxy
  apb_slave_mon_proxy_h.apb_slave_agent_cfg_h = apb_slave_agent_cfg_h;

endfunction: connect_phase

`endif

