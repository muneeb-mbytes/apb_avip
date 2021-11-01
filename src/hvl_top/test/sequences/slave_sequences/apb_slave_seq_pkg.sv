`ifndef APB_SLAVE_SEQ_PKG_INCLUDED_
`define APB_SLAVE_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_slave_seq_pkg
// Includes all the slave seq files declared
//--------------------------------------------------------------------------------------------
package apb_slave_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  import uvm_pkg::*;
  import apb_slave_pkg::*;

  //-------------------------------------------------------
  // Including required apb slave seq files
  //-------------------------------------------------------
  `include "slave_base_seq.sv"

endpackage : apb_slave_seq_pkg

`endif
