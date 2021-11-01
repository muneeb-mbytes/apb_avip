`ifndef MASTER_BASE_SEQ_INCLUDED_
`define MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : master_base_seq
// Creating master_base_seq extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class master_base_seq extends uvm_sequence;
  `uvm_object_utils(master_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_base_seq");
endclass : master_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_base_seq
//--------------------------------------------------------------------------------------------
function master_base_seq::new(string name = "master_base_seq");
  super.new(name);
endfunction : new

`endif
