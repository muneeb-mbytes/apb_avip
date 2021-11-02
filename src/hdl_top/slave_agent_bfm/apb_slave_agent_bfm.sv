`ifndef APB_SLAVE_AGENT_BFM_INCLUDED_
`define APB_SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : apb_slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_slave_agent_bfm(apb_if intf);
import uvm_pkg::*;
`include "uvm_macros.svh";
initial begin
  $display("SLAVE AGENT BFM");
end

  //-------------------------------------------------------
  //apb slave driver bfm instantiation
  //-------------------------------------------------------
  apb_slave_driver_bfm apb_slave_drv_bfm_h(intf);

  //-------------------------------------------------------
  //apb slave monitor bfm instantiation
  //-------------------------------------------------------
  apb_slave_monitor_bfm apb_slave_mon_bfm_h(intf);
  initial begin
   uvm_config_db#(virtual apb_slave_driver_bfm)::set(null,"*", "apb_slave_driver_bfm", apb_slave_drv_bfm_h); 
   uvm_config_db #(virtual apb_slave_monitor_bfm)::set(null,"*", "apb_slave_monitor_bfm", apb_slave_mon_bfm_h); 
 end

endmodule : apb_slave_agent_bfm

`endif
