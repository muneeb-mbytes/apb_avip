`ifndef APB_MASTER_BASE_SEQ_INCLUDED_
`define APB_MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : master_base_seq
// Creating master_base_seq extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class apb_master_base_seq extends uvm_sequence#(apb_master_tx);
  `uvm_object_utils(apb_master_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_base_seq");
endclass : apb_master_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_base_seq
//--------------------------------------------------------------------------------------------
function apb_master_base_seq::new(string name = "apb_master_base_seq");
  super.new(name);
endfunction : new

`endif
