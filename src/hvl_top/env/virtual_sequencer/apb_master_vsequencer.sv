`ifndef APB_MASTER_VSEQUENCER_INCLUDED_
`define APB_MASTER_VSEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_vsequencer
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class apb_master_vsequencer extends uvm_sequencer;
  `uvm_component_utils(apb_master_vsequencer)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_vsequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : apb_master_vsequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_vsequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_master_vsequencer::new(string name = "apb_master_vsequencer",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_vsequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_vsequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

`endif

