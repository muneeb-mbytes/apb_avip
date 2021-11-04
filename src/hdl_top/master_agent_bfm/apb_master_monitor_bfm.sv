//--------------------------------------------------------------------------------------------
// Module       : master Monitor BFM
// 
// Description  : Connects the master monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface apb_master_monitor_bfm();

   import uvm_pkg::*;
   `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_monitor_proxy;
  apb_master_monitor_proxy apb_master_mon_proxy_h;

  initial begin
    `uvm_info("apb master monitor bfm",$sformatf("APB MASTER MONITOR BFM"),UVM_LOW);

  end

endinterface : apb_master_monitor_bfm
