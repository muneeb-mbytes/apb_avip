`ifndef APB_MASTER_DRIVER_BFM_INCLUDED_
`define APB_MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : apb_master_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb Interface
//--------------------------------------------------------------------------------------------
interface apb_master_driver_bfm(input presetn,pclk,paddr,
                                  pselx,pprot,penable,pwrite,pwdata,pstrb, 
                                  output reg pslverr,pready,prdata);
   //-------------------------------------------------------
   //Importing uvm package file
   //-------------------------------------------------------
   import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_driver_proxy;

  //-------------------------------------------------------
  // variable: apb_master_drv_proxy_h
  // creating the handle for the proxy_driver
  //-------------------------------------------------------
  apb_master_driver_proxy apb_master_drv_proxy_h;

  initial begin
     `uvm_info("apb master driver bfm",$sformatf("APB MASTER DRIVER BFM"),UVM_LOW);
  end

  //-------------------------------------------------------
  // task: wait_for_presetn
  // waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_presetn();
    @(posedge presetn);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("system reset detected"),UVM_HIGH);

    @(negedge presetn);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("system reset deactivated"),UVM_HIGH);
  
  endtask: wait_for_presetn


  //-------------------------------------------------------
  // task: Drive_idle_state
  // this task drives the apb interface to idle state
  //
  // parameter: 
  // pselx - this signal selects the slave
  // penable - enable signal
  // paddr - address signal
  //-------------------------------------------------------
  task drive_idle_state(bit pselx, bit penable, bit paddr);
    @(posedge pclk);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("driving the idle state"),UVM_HIGH);endinterface
    pselx <= 0;
    penable <= 0;
    paddr <= 0;
  endtask: drive_idle_state


  //-------------------------------------------------------
  // task: drive_setup_state
  //-------------------------------------------------------
  task drive_setup_state(bit pselx, bit penable, bit paddr, bit pready);
    @(posedge pclk);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("driving the setup state"),UVM_HIGH);endinterface
    pselx <= 1;
    penable <= 0;
    paddr <= $urandom;
    pready <= 0;
  endtask: drive_setup_state

  //-------------------------------------------------------
  // task: drive_access_state
  //-------------------------------------------------------
  task drive_access_state(bit pselx, bit penable, bit paddr, bit pready, bit pwdata);
    @(posedge pclk);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("driving the setup state"),UVM_HIGH);endinterface
    pselx <= 1;
    penable <= 1;
    paddr <= $urandom;
    pwdata <= $urandom;
    //repeat(delay-1) begin
    //@(posedge pclk);
    //pready <= 0;
    //end
    
    pready <= 1;
  endtask: drive_access_state




endinterface : apb_master_driver_bfm

`endif
