`ifndef APB_SLAVE_MONITOR_BFM_INCLUDED_
`define APB_SLAVE_MONITOR_BFM_INCLUDED_I
//--------------------------------------------------------------------------------------------
// Inteface       : Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface apb_slave_monitor_bfm (apb_if intf);
  initial begin
    `uvm_info(get_type_name(),("Slave Monitor BFM"));
  end
endinterface : apb_slave_monitor_bfm
`endif
