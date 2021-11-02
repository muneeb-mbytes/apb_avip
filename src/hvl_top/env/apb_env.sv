`ifndef APB_ENV_INCLUDED_
`define APB_ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_env
// Creates master agent and slave agent and scoreboard
//--------------------------------------------------------------------------------------------
class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)

  //Variable : apb_master_agent_h
  //Declaring apb master agent handle
  apb_master_agent apb_master_agent_h;

  //Variable : apb_slave_agent_h
  //Declaring apb slave agent handle
  apb_slave_agent apb_slave_agent_h;

  //Variable : apb__scoreboard_h
  //Declaring apb scoreboard handle
  apb_scoreboard apb_scoreboard_h;

  //Variable : apb_virtual_seqr_h
  //Declaring apb virtual seqr handle
  apb_virtual_sequencer apb_virtual_seqr_h;


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
  apb_master_agent_h = apb_master_agent::type_id::create("apb_master_agent",this);
  apb_slave_agent_h = apb_slave_agent::type_id::create("apb_slave_agent",this);
  apb_scoreboard_h = apb_scoreboard::type_id::create("apb_scoreboard",this);
  apb_virtual_seqr_h = apb_virtual_sequencer::type_id::create("apb_virtual_sequencer",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects the mon and sb 
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


`endif
