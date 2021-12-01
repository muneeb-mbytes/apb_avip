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
import apb_global_pkg::*;
interface apb_slave_driver_bfm(input bit pclk,
                               input bit presetn,
                               input bit [2:0]pprot,
                               input bit pslverr,
                               input bit pready,
                               input logic penable,
                               input logic pwrite,
                               input logic [ADDRESS_WIDTH-1:0] paddr,
                               input logic [NO_OF_SLAVES-1:0] pselx,
                               input logic [DATA_WIDTH-1:0] pwdata,
                               input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                               input logic [DATA_WIDTH-1:0] prdata);
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
