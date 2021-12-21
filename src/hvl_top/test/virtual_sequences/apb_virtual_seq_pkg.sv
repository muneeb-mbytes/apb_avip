`ifndef APB_VIRTUAL_SEQ_PKG_INCLUDED_
`define APB_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_virtual_seq_pkg
// Includes all the master seq files declared
//--------------------------------------------------------------------------------------------
package apb_virtual_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import apb_env_pkg::*;
  import apb_master_pkg::*;
  import apb_slave_pkg::*;
  import apb_master_seq_pkg::*;
  import apb_slave_seq_pkg::*;

  //-------------------------------------------------------
  // Including required apb master seq files
  //-------------------------------------------------------
  `include "apb_virtual_base_seq.sv"
  `include "apb_virtual_vd_vws_seq.sv"
  `include "apb_virtual_8b_write_seq.sv"
  `include "apb_virtual_8b_write_read_seq.sv"
  `include "apb_virtual_16b_write_seq.sv"

endpackage : apb_virtual_seq_pkg

`endif
