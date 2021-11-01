`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_sequencer
// Creates master and slave sequences here
//--------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_component;
  `uvm_component_utils(virtual_sequencer)

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  apb_master_sequencer master_seqr_h;

  // Variable: slave_seqr_h
  // Declaring slave sequencer handle
  slave_sequencer  slave_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function virtual_sequencer::new(string name = "virtual_sequencer",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds the master and slave sequencers here.
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  master_seqr_h = apb_master_sequencer::type_id::create("master_seqr_h",this);
  slave_seqr_h = slave_sequencer::type_id::create("slave_seqr_h",this);
endfunction : build_phase


`endif

