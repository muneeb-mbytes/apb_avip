`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
  `uvm_object_utils(slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_tx");
endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

`endif

