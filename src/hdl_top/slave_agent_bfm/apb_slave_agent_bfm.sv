`ifndef APB_SLAVE_AGENT_BFM_INCLUDED_
`define APB_SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : apb_slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_slave_agent_bfm(apb_if intf);
  
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

endmodule : apb_slave_agent_bfm

`endif
