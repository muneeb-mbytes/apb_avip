//--------------------------------------------------------------------------------------------
// Module       : master Monitor BFM
// 
// Description  : Connects the master monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface apb_master_monitor_bfm (apb_if intf);
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_monitor_proxy;
  apb_master_monitor_proxy apb_master_mon_proxy_h;

  initial begin
    $display("apb master Monitor BFM");
  end

endinterface : apb_master_monitor_bfm
