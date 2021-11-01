//--------------------------------------------------------------------------------------------
// Interface : apb_master_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb Interface
//--------------------------------------------------------------------------------------------
interface apb_master_driver_bfm(apb_if drv_intf, apb_if.MON_MP mon_intf);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_slave_pkg::apb_master_driver_proxy;
  apb_master_driver_proxy apb_master_drv_proxy;

  initial begin
    $display("APB Master Driver BFM");
  end

endinterface : apb_master_driver_bfm
