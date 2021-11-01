`ifndef APB_VIRTUAL_BASE_SEQ_INCLUDED_
`define APB_VIRTUAL_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_virtual_base_seq
// Holds the handle of actual sequencer.
//--------------------------------------------------------------------------------------------
class apb_virtual_base_seq extends uvm_object;
  `uvm_object_utils(apb_virtual_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_virtual_base_seq");
endclass : apb_virtual_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_virtual_base_seq
//--------------------------------------------------------------------------------------------
function apb_virtual_base_seq::new(string name = "apb_virtual_base_seq");
  super.new(name);
endfunction : new

`endif

