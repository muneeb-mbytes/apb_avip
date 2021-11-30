`ifndef APB_MASTER_AGENT_BFM_INCLUDED_
`define APB_MASTER_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : APB Master Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_master_agent_bfm(apb_if intf);
 //-------------------------------------------------------
 //Importing uvm package file
 //-------------------------------------------------------
 import uvm_pkg::*;
`include "uvm_macros.svh"

 initial begin
       `uvm_info("apb master agent bfm",$sformatf("APB MASTER AGENT BFM"),UVM_LOW);
  end

  //-------------------------------------------------------
  //master driver bfm instantiation
  //-------------------------------------------------------
  apb_master_driver_bfm apb_master_drv_bfm_h ();

  //-------------------------------------------------------
  //master monitor bfm instantiation
  //-------------------------------------------------------
  apb_master_monitor_bfm apb_master_mon_bfm_h ();

  //-------------------------------------------------------
  //setting the virtualhandle of BFMs into config_db
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual apb_master_driver_bfm)::set(null,"*","apb_master_driver_bfm",apb_master_drv_bfm_h);
    uvm_config_db#(virtual apb_master_monitor_bfm)::set(null,"*","apb_master_monitor_bfm",apb_master_mon_bfm_h);
  end
endmodule : apb_master_agent_bfm

`endif
