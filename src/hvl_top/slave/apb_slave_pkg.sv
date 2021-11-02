`ifndef APB_SLAVE_PKG_INCLUDED_
`define APB_SLAVE_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: apb_slave_pkg
//  Includes all the files related to APB slave
//--------------------------------------------------------------------------------------------
package apb_slave_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

 // // Import spi_globals_pkg 
 // import spi_globals_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "apb_slave_tx.sv"
  //`include "slave_spi_seq_item_converter.sv"
  `include "apb_slave_agent_config.sv"
  `include "apb_slave_sequencer.sv"
// `include "slave_sequence.sv"
  `include "apb_slave_driver_proxy.sv"
  `include "apb_slave_monitor_proxy.sv"
  //`include "apb_slave_coverage.sv"
  `include "apb_slave_agent.sv"
  
endpackage : apb_slave_pkg

`endif
