`ifndef APB_MASTER_SEQ_PKG_INCLUDED_
`define APB_MASTER_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_master_seq_pkg
// Includes all the master seq files declared
//--------------------------------------------------------------------------------------------
package apb_master_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import apb_global_pkg::*;
  import uvm_pkg::*;
  import apb_master_pkg::*;

  //-------------------------------------------------------
  // Including required apb master seq files
  //-------------------------------------------------------
  `include "apb_master_base_seq.sv"
  `include "apb_master_vd_vws_seq.sv"
  `include "apb_master_8b_write_seq.sv"
  `include "apb_master_8b_write_read_seq.sv"
  `include "apb_master_16b_write_seq.sv"
  `include "apb_master_24b_write_seq.sv"
  `include "apb_master_8b_read_seq.sv"
endpackage : apb_master_seq_pkg

`endif
