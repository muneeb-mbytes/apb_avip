//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Including APB interface and apb_Slave Agent BFM Files
//-------------------------------------------------------
module hdl_top;
import uvm_pkg::*;
`include "uvm_macros.svh"
  //-------------------------------------------------------
  // Clock Reset Initialization
  //-------------------------------------------------------
 // bit clk;
  //bit rst;

  //-------------------------------------------------------
  // Display statement for HDL_TOP
  //-------------------------------------------------------
  initial begin
    `uvm_info("UVM_INFO","HDL_TOP",UVM_LOW);
    $display("HDL TOP");
  end

  bit pclk=0;
  bit presetn=1;
  always #10 pclk = !pclk;
  initial begin
    #40 presetn = 0;
    #60 presetn = 1;
  end

  //-------------------------------------------------------
  // apb Interface Instantiation
  //-------------------------------------------------------
  apb_if intf(pclk,presetn);

  //-------------------------------------------------------
  // apb Master BFM Agent Instantiation
  //-------------------------------------------------------
  apb_master_agent_bfm apb_master_agent_bfm_h(intf); 
  
  //-------------------------------------------------------
  // apb slave BFM Agent Instantiation
  //-------------------------------------------------------
  apb_slave_agent_bfm apb_slave_agent_bfm_h(intf);

endmodule : hdl_top
