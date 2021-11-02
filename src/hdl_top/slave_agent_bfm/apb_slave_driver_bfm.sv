`ifndef APB_SLAVE_DRIVER_BFM_INCLUDED_
`define APB_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Interface : apb_slave_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb interface
//--------------------------------------------------------------------------------------------
interface apb_slave_driver_bfm(apb_if intf);
//-------------------------------------------------------
//creating handle for apb slave driver proxy
//-------------------------------------------------------
import apb_slave_pkg::apb_slave_driver_proxy;
apb_slave_driver_proxy apb_slave_drv_proxy_h;
  initial begin
    $display("Slave Driver BFM");
  end
endinterface : apb_slave_driver_bfm
`endif
