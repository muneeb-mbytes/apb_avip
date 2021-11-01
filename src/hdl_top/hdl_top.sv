//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Including APB interface and apb_Slave Agent BFM Files
//-------------------------------------------------------
module hdl_top;
//import uvm_pkg::*;
//`include "uvm_macros.svh"
  //-------------------------------------------------------
  // Clock Reset Initialization
  //-------------------------------------------------------
 // bit clk;
  //bit rst;

  //-------------------------------------------------------
  // Display statement for HDL_TOP
  //-------------------------------------------------------
  initial begin
    //`uvm_info(get_type_name(),("HDL_TOP"));
    $display("HDL TOP");
  end

  //-------------------------------------------------------
  // apb Interface Instantiation
  //-------------------------------------------------------
  apb_if intf();

  //-------------------------------------------------------
  // apb Master BFM Agent Instantiation
  //-------------------------------------------------------
  apb_master_agent_bfm apb_master_agent_bfm_h(intf); 
  
  //-------------------------------------------------------
  // apb slave BFM Agent Instantiation
  //-------------------------------------------------------
  apb_slave_agent_bfm apb_slave_agent_bfm_h(intf);

endmodule : hdl_top
