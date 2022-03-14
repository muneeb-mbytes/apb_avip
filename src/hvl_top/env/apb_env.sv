`ifndef APB_ENV_INCLUDED_
`define APB_ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_env
// Creates master agent and slave agent and scoreboard
//--------------------------------------------------------------------------------------------
class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)

  //Variable: apb_master_agent_h
  //Declaring apb master agent handle
  apb_master_agent apb_master_agent_h;

  //Variable: apb_slave_agent_h
  //Declaring apb slave agent handle
  apb_slave_agent apb_slave_agent_h[];

  //Variable: apb_scoreboard_h
  //Declaring apb scoreboard handle
  apb_scoreboard apb_scoreboard_h;

  //Variable: apb_virtual_seqr_h
  //Declaring apb virtual seqr handle
  apb_virtual_sequencer apb_virtual_seqr_h;
  
  //Variable: apb_env_cfg_h
  //Declaring handle for apb_env_config_object
  apb_env_config apb_env_cfg_h;  
  
  //Variable: apb_slave_agent_cfg_h;
  //Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h[];

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : apb_env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_env::new(string name = "apb_env",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds the master and slave agents and scoreboard
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(apb_env_config)::get(this,"","apb_env_config",apb_env_cfg_h)) begin
   `uvm_fatal("FATAL_ENV_CONFIG", $sformatf("Couldn't get the env_config from config_db"))
  end
  apb_slave_agent_cfg_h = new[apb_env_cfg_h.no_of_slaves];
  
  foreach(apb_slave_agent_cfg_h[i]) begin
    if(!uvm_config_db #(apb_slave_agent_config)::get(this,"",$sformatf("apb_slave_agent_config[%0d]",i),apb_slave_agent_cfg_h[i])) begin
      `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the apb_slave_agent_config[%0d] from config_db",i))
    end
  end
  
  apb_master_agent_h = apb_master_agent::type_id::create("apb_master_agent",this);
  
  apb_slave_agent_h = new[apb_env_cfg_h.no_of_slaves];
  foreach(apb_slave_agent_h[i]) begin
    apb_slave_agent_h[i] = apb_slave_agent::type_id::create($sformatf("apb_slave_agent_h[%0d]",i),this);
  end

  if(apb_env_cfg_h.has_virtual_seqr) begin
    apb_virtual_seqr_h = apb_virtual_sequencer::type_id::create("apb_virtual_seqr_h",this);
  end

  if(apb_env_cfg_h.has_scoreboard) begin
    apb_scoreboard_h = apb_scoreboard::type_id::create("apb_scoreboard_h",this);
  end

  foreach(apb_slave_agent_h[i]) begin
    apb_slave_agent_h[i].apb_slave_agent_cfg_h = apb_slave_agent_cfg_h[i];
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//  Connects the master agent monitor's analysis_port with scoreboard's analysis_fifo 
//  Connects the slave agent monitor's analysis_port with scoreboard's analysis_fifo 
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(apb_env_cfg_h.has_virtual_seqr) begin
    apb_virtual_seqr_h.apb_master_seqr_h = apb_master_agent_h.apb_master_seqr_h;
    foreach(apb_slave_agent_h[i]) begin
      apb_virtual_seqr_h.apb_slave_seqr_h = apb_slave_agent_h[i].apb_slave_seqr_h;
    end
  end
  
  apb_master_agent_h.apb_master_mon_proxy_h.apb_master_analysis_port.connect(apb_scoreboard_h
                                                                    .apb_master_analysis_fifo.analysis_export);
  
  foreach(apb_slave_agent_h[i]) begin
    apb_slave_agent_h[i].apb_slave_mon_proxy_h.apb_slave_analysis_port.connect(apb_scoreboard_h
                                                                      .apb_slave_analysis_fifo[i].analysis_export);
  end
  
endfunction : connect_phase

`endif

