`ifndef APB_SLAVE_DRIVER_BFM_INCLUDED_
`define APB_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Interface : apb_slave_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb Interface
//--------------------------------------------------------------------------------------------
interface apb_slave_driver_bfm(apb_if intf);
  initial begin
    //`uvm_info("----",("Slave Driver BFM"));
    $display("Slave Driver BFM");
  end
endinterface : apb_slave_driver_bfm
`endif
