`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_virtual_sequencer
// Creates master and slave sequences here
//--------------------------------------------------------------------------------------------
class apb_virtual_sequencer extends uvm_component;
  `uvm_component_utils(apb_virtual_sequencer)

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  apb_master_vsequencer apb_master_vseqr_h;

  // Variable: slave_seqr_h
  // Declaring slave sequencer handle
  apb_slave_vsequencer  apb_slave_vseqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_virtual_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : apb_virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_virtual_sequencer::new(string name = "apb_virtual_sequencer",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds the master and slave sequencers here.
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  apb_master_vseqr_h = apb_master_vsequencer::type_id::create("apb_master_vseqr_h",this);
  apb_slave_vseqr_h = apb_slave_vsequencer::type_id::create("apb_slave_vseqr_h",this);
endfunction : build_phase


`endif
