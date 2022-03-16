`ifndef APB_SLAVE_BASE_SEQ_INCLUDED_
`define APB_SLAVE_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : slave_base_seq
//  Creating slave_base_seq extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class apb_slave_base_seq extends uvm_sequence#(apb_slave_tx);
  `uvm_object_utils(apb_slave_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_base_seq");

endclass : apb_slave_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_base_seq
//--------------------------------------------------------------------------------------------
function apb_slave_base_seq::new(string name = "apb_slave_base_seq");
  super.new(name);
endfunction : new

`endif

