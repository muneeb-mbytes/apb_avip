`ifndef apb_master_agent_BFM_INCLUDED_
`define apb_master_agent_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : APB Master Agent BFM
// 
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module apb_master_agent_bfm(apb_if intf);
  
  initial begin
    $display("APB Master Agent BFM");
  end

  //-------------------------------------------------------
  //master driver bfm instantiation
  //-------------------------------------------------------
  apb_master_driver_bfm apb_master_drv_bfm_h (intf.MAS_DRV_MP, intf.MON_MP);

  //-------------------------------------------------------
  //master monitor bfm instantiation
  //-------------------------------------------------------
  apb_master_monitor_bfm apb_master_mon_bfm_h (intf.MON_MP);

endmodule : apb_master_agent_bfm


