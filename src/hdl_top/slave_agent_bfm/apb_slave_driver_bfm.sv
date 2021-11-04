`ifndef APB_SLAVE_DRIVER_BFM_INCLUDED_
`define APB_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Interface : apb_slave_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb interface
//--------------------------------------------------------------------------------------------
interface apb_slave_driver_bfm();
  //-------------------------------------------------------
  // importing uvm_pkg file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
//-------------------------------------------------------
//creating handle for apb slave driver proxy
//-------------------------------------------------------

import apb_slave_pkg::apb_slave_driver_proxy;
apb_slave_driver_proxy apb_slave_drv_proxy_h;

initial begin
  `uvm_info("apb slave driver bfm",$sformatf("APB SLAVE DRIVER BFM"),UVM_LOW);
end

endinterface : apb_slave_driver_bfm

`endif
