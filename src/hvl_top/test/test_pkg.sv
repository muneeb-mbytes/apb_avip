`ifndef TEST_PKG_INCLUDED_
`define TEST_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import apb_global_pkg::*;
  import apb_master_pkg::*;
  import apb_slave_pkg::*;
  import apb_env_pkg::*;
  //import apb_master_seq_pkg::*;
  //import apb_slave_seq_pkg::*;
  //import apb_virtual_seq_pkg::*;
  
  //-------------------------------------------------------
  // Including the base test files
  //-------------------------------------------------------
 `include "base_test.sv"

endpackage : test_pkg

`endif
