`ifndef APB_MASTER_MONITOR_BFM_INCLUDED_
`define APB_MASTER_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface       : master Monitor BFM
// 
// Description  : Connects the master monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

import apb_global_pkg::*;

interface apb_master_monitor_bfm (input bit pclk,
                                  input bit presetn,
                                  input bit pprot,
                                  input bit pslverr,
                                  input bit pready,
                                  input logic penable,
                                  input logic pwrite,
                                  input logic [ADDRESS_WIDTH-1:0] paddr,
                                  input logic [NO_OF_SLAVES-1:0] pselx,
                                  input logic [DATA_WIDTH-1:0] pwdata,
                                  input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                                  input logic [DATA_WIDTH-1:0] prdata
                                );

   //-------------------------------------------------------
   //Importing uvm package file
   //-------------------------------------------------------
   import uvm_pkg::*;
   `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_monitor_proxy;

  // Variable: apb_master_mon_proxy_h
  // Declaring handle for apb_master_monitor_proxy  
  apb_master_monitor_proxy apb_master_mon_proxy_h;

  initial begin
    `uvm_info("apb master monitor bfm",$sformatf("APB MASTER MONITOR BFM"),UVM_LOW);
  end

endinterface : apb_master_monitor_bfm

`endif
