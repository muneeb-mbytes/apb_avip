`ifndef SLAVE_BASE_SEQ_INCLUDED_
`define SLAVE_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : slave_base_seq
// Creating slave_base_seq extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class slave_base_seq extends uvm_sequence;
  `uvm_object_utils(slave_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_base_seq");
endclass : slave_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_base_seq
//--------------------------------------------------------------------------------------------
function slave_base_seq::new(string name = "slave_base_seq");
  super.new(name);
endfunction : new

`endif
