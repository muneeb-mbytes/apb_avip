`ifndef APB_SLAVE_MONITOR_BFM_INCLUDED_
`define APB_SLAVE_MONITOR_BFM_INCLUDED_I
//--------------------------------------------------------------------------------------------
// Inteface       : apb Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface apb_slave_monitor_bfm (apb_if intf);
  initial begin
    //`uvm_info("-------",("Slave Monitor BFM"),UVM_LOW);
    $display("SLAVE MONITOR BFM");
  end
endinterface : apb_slave_monitor_bfm
`endif
