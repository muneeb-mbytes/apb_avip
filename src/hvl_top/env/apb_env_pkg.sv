`ifndef APB_ENV_PKG_INCLUDED_
`define APB_ENV_PKG_INCLUDED_

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
  `include "apb_env_config.sv"
  `include "apb_virtual_sequencer.sv"
  `include "apb_scoreboard.sv"
  `include "apb_env.sv"

endpackage : apb_env_pkg

`endif

