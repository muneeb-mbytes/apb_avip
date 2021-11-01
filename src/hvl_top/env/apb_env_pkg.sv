`ifndef SPI_ENV_PKG_INCLUDED_
`define SPI_ENV_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: apb_env_pkg
// Includes all the files related to apb env
//--------------------------------------------------------------------------------------------
package apb_env_pkg;
  
  //-------------------------------------------------------
  // Importing uvm packages
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import apb_global_pkg::*;
  import apb_master_pkg::*;
  import apb_slave_pkg::*;

  //-------------------------------------------------------
  // Including the required files
  //-------------------------------------------------------
  `include "env_config.sv"
  `include "virtual_sequencer.sv"
  `include "apb_scoreboard.sv"
  `include "env.sv"
  `include "coverage.sv"

endpackage : apb_env_pkg

`endif
