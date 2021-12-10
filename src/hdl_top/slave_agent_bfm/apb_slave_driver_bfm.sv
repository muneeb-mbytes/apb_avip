`ifndef APB_SLAVE_DRIVER_BFM_INCLUDED_
`define APB_SLAVE_DRIVER_BFM_INCLUDED_

//-------------------------------------------------------
// Importing apb global package
//-------------------------------------------------------
import apb_global_pkg::*;

//--------------------------------------------------------------------------------------------
// Interface : apb_slave_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb interface
//--------------------------------------------------------------------------------------------
interface apb_slave_driver_bfm(input bit pclk,
                               input bit preset_n,
                               input logic psel,
                               input logic penable,
                               input logic [ADDRESS_WIDTH-1:0] paddr,
                               input logic pwrite,
                               input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                               input logic [DATA_WIDTH-1:0] pwdata,
                               output bit pslverr,
                               output bit pready,
                               input bit [2:0]pprot,
                               output logic [DATA_WIDTH-1:0] prdata);

  //-------------------------------------------------------
  // Importing uvm package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing slave driver proxy
  //------------------------------------------------------- 
  import apb_slave_pkg::apb_slave_driver_proxy;

  //Variable : apb_slave_drv_proxy_h
  //Declaring handle for apb_slave_driver_proxy
  apb_slave_driver_proxy apb_slave_drv_proxy_h;
  
  //Variable : name
  //Used to store the name of the interface
  string name = "APB_SLAVE_DRIVER_BFM";

  //-------------------------------------------------------
  // Used to display the name of the interface
  //-------------------------------------------------------
  initial begin
    `uvm_info(name,$sformatf(name),UVM_LOW);
  end

  //-------------------------------------------------------
  // Task: wait_for_preset_n
  // Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();

    @(negedge preset_n);
    `uvm_info(name,$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)

    @(posedge preset_n);
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  
  endtask: wait_for_preset_n
  
  //-------------------------------------------------------
  // Task: wait_for_setup_state
  // Samples the required data and sends back to the proxy
  //-------------------------------------------------------
  task wait_for_setup_state(output apb_transfer_char_s data_packet);
    @(posedge pclk);
    `uvm_info(name,$sformatf("WAITING FOR SETUP STATE"),UVM_HIGH)

    while(psel != 1) begin
      @(posedge pclk);
    end

    // Sampling the signals
    data_packet.paddr  = paddr;
    data_packet.pwrite = pwrite;
    if(pwrite == WRITE) begin
      data_packet.pwdata = pwdata;
      data_packet.pstrb  = pstrb;
    end
    data_packet.pprot = pprot;


    // TODO(mshariff): 
    // Get the required READ data and/ PSLVERR
    //
    //data_packet.pstrb<=pstrb;
    //data_packet.pready<=pready;
    // MSHA: end

  endtask: wait_for_setup_state

  //-------------------------------------------------------
  // Task: wait_for_access_state
  // Samples the data or drives the data to master based
  // on pwrite signal
  //-------------------------------------------------------
  task wait_for_access_state(inout apb_transfer_char_s data_packet);
    @(posedge pclk);
    `uvm_info(name,$sformatf("WAITING FOR ACCESS STATE - no_of_wait_states=%0d",data_packet.no_of_wait_states),UVM_HIGH);

    repeat(data_packet.no_of_wait_states)begin
      `uvm_info(name,$sformatf("INSIDE ACCESS - DRIVING WAIT STATE"),UVM_HIGH);
      @(posedge pclk);
      pready<=0;
    end

    pready<=1;

    if(data_packet.pwrite == READ) begin
      prdata <= 32'hDEAD_BEEF;
    end

    // TODO(mshariff): 
    pslverr <= 0;

  endtask: wait_for_access_state

endinterface : apb_slave_driver_bfm

`endif
