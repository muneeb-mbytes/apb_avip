`ifndef APB_SLAVE_MONITOR_BFM_INCLUDED_
`define APB_SLAVE_MONITOR_BFM_INCLUDED_I
//--------------------------------------------------------------------------------------------
// Inteface       : apb Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from apb monitor bfm to apb monitor proxy
//--------------------------------------------------------------------------------------------
 
interface apb_slave_monitor_bfm (apb_if intf);
  //-------------------------------------------------------
//creating handle for apb slave monitor proxy
//-------------------------------------------------------
import apb_slave_pkg::apb_slave_monitor_proxy;
apb_slave_monitor_proxy apb_slave_mon_proxy_h;

  initial begin
    $display("APB SLAVE MONITOR BFM");
  end
endinterface : apb_slave_monitor_bfm
`endif
