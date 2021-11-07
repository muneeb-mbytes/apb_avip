`ifndef APB_MASTER_DRIVER_BFM_INCLUDED_
`define APB_MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : apb_master_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb Interface
//--------------------------------------------------------------------------------------------
interface apb_master_driver_bfm();
   //-------------------------------------------------------
   //Importing uvm package file
   //-------------------------------------------------------
   import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_driver_proxy;
  apb_master_driver_proxy apb_master_drv_proxy_h;

  initial begin
     `uvm_info("apb master driver bfm",$sformatf("APB MASTER DRIVER BFM"),UVM_LOW);
  end

endinterface : apb_master_driver_bfm

`endif
