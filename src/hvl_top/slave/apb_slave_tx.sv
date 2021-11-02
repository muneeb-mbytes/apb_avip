`ifndef APB_SLAVE_TX_INCLUDED_
`define APB_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_tx");
endclass : apb_slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function apb_slave_tx::new(string name = "apb_slave_tx");
  super.new(name);
endfunction : new

`endif

