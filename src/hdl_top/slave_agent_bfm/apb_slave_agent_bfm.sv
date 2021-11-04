`ifndef APB_SLAVE_AGENT_BFM_INCLUDED_
`define APB_SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : apb_slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_slave_agent_bfm(apb_if intf);
  //-------------------------------------------------------
  // importing uvm_pkg file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  initial begin
    `uvm_info("apb slave agent bfm",$sformatf("APB SLAVE AGENT BFM"),UVM_LOW);
  end

  //-------------------------------------------------------
  //apb slave driver bfm instantiation
  //-------------------------------------------------------
  apb_slave_driver_bfm apb_slave_drv_bfm_h();

  //-------------------------------------------------------
  //apb slave monitor bfm instantiation
  //-------------------------------------------------------
  apb_slave_monitor_bfm apb_slave_mon_bfm_h();
  initial begin
   uvm_config_db#(virtual apb_slave_driver_bfm)::set(null,"*", "apb_slave_driver_bfm", apb_slave_drv_bfm_h); 
   uvm_config_db #(virtual apb_slave_monitor_bfm)::set(null,"*", "apb_slave_monitor_bfm", apb_slave_mon_bfm_h); 
 end

endmodule : apb_slave_agent_bfm

`endif
