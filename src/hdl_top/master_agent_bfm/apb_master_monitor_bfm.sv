`ifndef APB_MASTER_MONITOR_BFM_INCLUDED_
`define APB_MASTER_MONITOR_BFM_INCLUDED_

//-------------------------------------------------------
// Importing apb global package
//-------------------------------------------------------
import apb_global_pkg::*;

//--------------------------------------------------------------------------------------------
// Interface: apb_master_monitor_bfm
// Connects the master monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------
interface apb_master_monitor_bfm (input bit pclk,
                                  input bit preset_n,
                                  input bit pslverr,
                                  input bit pready,
                                  input bit [2:0]pprot,
                                  input logic penable,
                                  input logic pwrite,
                                  input logic [ADDRESS_WIDTH-1:0] paddr,
                                  input logic [NO_OF_SLAVES-1:0] pselx,
                                  input logic [DATA_WIDTH-1:0] pwdata,
                                  input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                                  input logic [DATA_WIDTH-1:0] prdata
                                );

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_monitor_proxy;

  //Variable: apb_master_mon_proxy_h
  //Declaring handle for apb_master_monitor_proxy  
  apb_master_monitor_proxy apb_master_mon_proxy_h;

  initial begin
    `uvm_info("apb master monitor bfm",$sformatf("APB MASTER MONITOR BFM"),UVM_LOW);
  end

  //-------------------------------------------------------
  // Task: wait_for_preset_n
  // Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();
    @(posedge preset_n);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("system reset detected"),UVM_HIGH)
    
    @(negedge preset_n);
    `uvm_info("MASTER_DRIVER_BFM",$sformatf("system reset deactivated"),UVM_HIGH)
  endtask: wait_for_preset_n

  //-------------------------------------------------------
  // Task: drive_idle_state
  // This task waits for the apb on interface
  //
  // Parameter: 
  // pselx - this signal selects the slave
  // penable - enable signal
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);
    while (pselx == '0) begin
      @(negedge pclk);
    end
    `uvm_info("MASTER_MONITOR_BFM",$sformatf("waiting for the idle state"),UVM_HIGH)
  endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: wait_for_transfer_start
  // waits for penable to be active high
  //
  // Parameter:
  // penable - enable signal
  //-------------------------------------------------------
  task wait_for_transfer_start();
    @(negedge pclk);
    while (penable == 1) begin
      @(negedge pclk);
    end
   `uvm_info("MASTER_MONITOR_BFM",$sformatf("waiting for the transfer to start"),UVM_HIGH)
  endtask: wait_for_transfer_start

  //task sample_data(output apb_transfer_char_s apb_data_packet, input apb_transfer_cfg_s apb_cfg_pkt);
  task sample_data(output apb_transfer_char_s apb_data_packet, input apb_transfer_cfg_s apb_cfg_packet);
    forever begin
      if(penable==1 && pready==1 && $countones(pselx)==1) begin
        apb_data_packet.prdata = prdata;
        apb_data_packet.pwdata = pwdata;
      end
    end
  endtask: sample_data

endinterface : apb_master_monitor_bfm

`endif

