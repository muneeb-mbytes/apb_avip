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
import apb_global_pkg::*;
interface apb_slave_driver_bfm(input bit pclk,
                               input bit preset_n,
                               input bit [2:0]pprot,
                               output bit pslverr,
                               output bit pready,
                               input logic penable,
                               input logic pwrite,
                               input logic [ADDRESS_WIDTH-1:0] paddr,
                               input logic [NO_OF_SLAVES-1:0] pselx,
                               input logic [DATA_WIDTH-1:0] pwdata,
                               input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                               output logic [DATA_WIDTH-1:0] prdata);

//-------------------------------------------------------
//importing uvm packages
//-------------------------------------------------------
import uvm_pkg::*;
`include "uvm_macros.svh"

//-------------------------------------------------------
//creating handle for apb slave driver proxy
//-------------------------------------------------------

import apb_slave_pkg::apb_slave_driver_proxy;
apb_slave_driver_proxy apb_slave_drv_proxy_h;
//bit end_of_transfer;
initial begin
  `uvm_info("apb slave driver bfm",$sformatf("APB SLAVE DRIVER BFM"),UVM_LOW);
end

  //-------------------------------------------------------
  // task: wait_for_preset_n
  // waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();
    @(negedge preset_n);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("system reset detected"),UVM_HIGH)

    @(posedge preset_n);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("system reset deactivated"),UVM_HIGH)
  
  endtask: wait_for_preset_n
//-------------------------------------------------------
//task: drive to bfm
//this task will drive the data from bfm to proxy using converters

// Parameters:
// data_packet  - handle for apb_transfer_char_s
// cfg_pkt      - handle for apb_transfer_cfg_s
//-------------------------------------------------------

   task drive_to_bfm(inout apb_transfer_char_s data_packet,
                          input apb_transfer_cfg_s cfg_pkt);
    @(posedge pclk);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("driving the setup state"),UVM_HIGH);

   // wait_for_idle_state(data_packet);

    wait_for_setup_state(data_packet);

    wait_for_access_state(data_packet);
    /*
    pselx <= data_packet.pselx;
    penable <= data_packet.penable;
    paddr <= data_packet.paddr;
    pwdata <= data_packet.pwdata;
    pready <= data_packet.pready;
    */
    endtask: drive_to_bfm
  //-------------------------------------------------------
  // task: wait_for_idle_state
  // this task drives the apb interface to idle state
  //
  // pselx - this signal selects the slave
  // penable - enable signal
  // paddr - address signal
  //-------------------------------------------------------
  
  /*task wait_for_idle_state(apb_transfer_char_s data_packet);
    @(posedge pclk);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("driving the idle state"),UVM_HIGH)
    data_packet.pselx <= pselx;
    //data_packet.penable <= penable;

  endtask: wait_for_idle_state
  */

  //-------------------------------------------------------
  // task: wait_for_setup_state
  //-------------------------------------------------------
  task wait_for_setup_state(apb_transfer_char_s data_packet);
    @(posedge pclk);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("driving the setup state"),UVM_HIGH)
    if($countones(pselx) == 1)begin
      data_packet.pselx = 1;
      //data_packet.penable = penable;
    end
    if(data_packet.pselx == 1 && penable == 0) begin
    data_packet.paddr<=paddr;
    data_packet.pwrite<=pwrite;
    data_packet.pwdata<=pwdata;
    data_packet.prdata<=prdata;
    //data_packet.pstrb<=pstrb;
    //data_packet.pready<=pready;
  end

  endtask: wait_for_setup_state

  //-------------------------------------------------------
  // task: wait_for_access_state
  //-------------------------------------------------------
  task wait_for_access_state(input apb_transfer_char_s data_packet);
    @(posedge pclk);
    `uvm_info("SLAVE_DRIVER_BFM",$sformatf("driving the setup state"),UVM_HIGH);
    if($countones(pselx) == 1)begin
      data_packet.pselx = 1;
      //data_packet.penable = penable;
    end
    if(data_packet.pselx == 1 && penable == 1) begin
      repeat(data_packet.no_of_wait_states)begin
        @(posedge pclk);
        pready<=0;
      end
      pready<=1;
    end
    if($countones(pselx) == 1 && penable==1)begin
      if(pwrite == 1'b1) begin
        data_packet.pwdata=pwdata;
      end
      else begin
        prdata <= data_packet.prdata;
      end
    end

    //data_packet.pselx = pselx;
    //data_packet.penable = penable;
    //data_packet.pstrb <= pstrb;
    //data_packet.pprot <= pprot;
  //if(data_packet.pselx == 1 && penable == 1) begin
   // data_packet.paddr <= paddr;
    //data_packet.pwrite <= pwrite;
    //if(pwrite == 1) begin
      //data_packet.pwdata = pwdata;
     // end_of_transfer=1'b1;
    //end
    //else begin
      //prdata <= data_packet.prdata;
     // end_of_transfer = 1'b1;
    //end
    //end
    //pselx[0] <= 1'b1;
    //penable <= 1'b1;
   // data_packet.paddr=paddr;
    //data_packet.pwrite=pwrite;
    //pready = data_packet.pready;
    //data_packet
    //if(pready == 1'b1) begin
      //transfer_data(data_packet);
    //end
    //else begin
      //Wait State
      //drive_wait_state(data_packet,penable);
    //end
    
    //end_of_transfer_check(paddr,pready,penable);
    //repeat(delay-1) begin
    //@(posedge pclk);
    //pready <= 0;
    //end
    //pready <= data_packet.pready;
  endtask: wait_for_access_state

//-------------------------------------------------------
//task: transfer_data
//
//-------------------------------------------------------
  task transfer_data(apb_transfer_char_s data_packet);
    if(pwrite == 1'b1) begin
      data_packet.pwdata=pwdata;
      //end_of_transfer = 1'b1;
    end
    else begin
      prdata = data_packet.prdata;
      //end_of_transfer = 1'b1;
    end
  endtask :transfer_data
//-------------------------------------------------------
//task: drive_wait_state
//
//-------------------------------------------------------
  task drive_wait_state(apb_transfer_char_s data_packet, bit penable);
    data_packet.paddr=paddr;
    data_packet.pwrite=pwrite;
    //pready=data_packet.pready;
  while(penable) begin
    if(!pready) begin
      `uvm_info("SLAVE_DRIVER_BFM","WAIT_STATE_DETECTED",UVM_LOW);
      @(posedge pclk);
      end
      else begin
        transfer_data(data_packet);
      end
    end
  endtask : drive_wait_state
/*
  task end_of_transfer_check(input bit paddr,input bit pready, input bit penable);
    if(end_of_transfer && pready) begin
     // drive_setup_state(paddr);
     wait_for_setup_state(paddr);
    end
    else if(!end_of_transfer && pready) begin
      //drive_idle_state();
      wait_for_idle_state();
    end
  endtask : end_of_transfer_check
*/
endinterface : apb_slave_driver_bfm

`endif
