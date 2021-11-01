`ifndef APB_SLAVE_AGENT_BFM_INCLUDED_
`define APB_SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : apb_slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_slave_agent_bfm(apb_if intf);
  
  initial begin
    `uvm_info(get_type_name(),$sformat("apb_slave Agent BFM"));
  end

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  apb_slave_driver_bfm apb_slave_drv_bfm_h ;

  //-------------------------------------------------------
  //Slave monitor bfm instantiation
  //-------------------------------------------------------
  apb_slave_monitor_bfm apb_slave_mon_bfm_h;

endmodule : apb_slave_agent_bfm

`endif
