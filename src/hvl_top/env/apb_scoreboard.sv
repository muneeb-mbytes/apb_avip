`ifndef APB_SCOREBOARD_INCLUDED_
`define APB_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_scoreboard
// Used to compare the data from the master monitor proxy and slave monitor proxy
//--------------------------------------------------------------------------------------------
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  //Variable : apb_master_tx_h
  //Declaring handle for apb_master_tx
  //apb_master_tx apb_master_tx_h;

  //Variable : apb_slave_tx_h
  //Declaring handle for apb_slaver_tx
  //apb_slave_tx apb_slave_tx_h;
  
  //Variable : apb_master_analysis_fifo
  //Used to store the apb_master_data
  uvm_tlm_analysis_fifo#(apb_master_tx) apb_master_analysis_fifo;

  //Variable : apb_slave_analysis_fifo
  //Used to store the apb_slave_data
  uvm_tlm_analysis_fifo#(apb_slave_tx) apb_slave_analysis_fifo;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_scoreboard::new(string name = "apb_scoreboard",uvm_component parent = null);
  super.new(name, parent);
  apb_master_analysis_fifo = new("apb_master_analysis_fifo",this);
  apb_slave_analysis_fifo  = new("apb_slave_analysis_fifo",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds its parent components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_scoreboard::run_phase(uvm_phase phase);

  phase.raise_objection(this, "apb_scoreboard");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

