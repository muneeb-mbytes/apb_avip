`ifndef APB_MASTER_DRIVER_BFM_INCLUDED_
`define APB_MASTER_DRIVER_BFM_INCLUDED_

import apb_global_pkg::*;
//--------------------------------------------------------------------------------------------
// Interface : apb_master_driver_bfm
//  Used as the HDL driver for apb
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - apb Interface
//--------------------------------------------------------------------------------------------
interface apb_master_driver_bfm (input  bit   pclk,
                                 input  bit   preset_n,
                                 input  bit   pready,
                                 input  bit   pslverr,
                                 input  logic [DATA_WIDTH-1:0]prdata,
                                 output logic [2:0]pprot,
                                 output logic penable,
                                 output logic pwrite,
                                 output logic [ADDRESS_WIDTH-1:0] paddr,
                                 output logic [NO_OF_SLAVES-1:0] pselx,
                                 output logic [DATA_WIDTH-1:0] pwdata,
                                 output logic [(DATA_WIDTH/8)-1:0] pstrb
                                );

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing the master package file
  //-------------------------------------------------------
  import apb_master_pkg::apb_master_driver_proxy;
  
  //Variable: end_of_transfer
  //Used to indicate the end of transfer of the packet
  //bit end_of_transfer;

  string name = "APB_MASTER_DRIVER_BFM"; 
  
  //Variable: apb_master_drv_proxy_h
  //Creating the handle for the proxy_driver
  apb_master_driver_proxy apb_master_drv_proxy_h;
 
  initial begin
    `uvm_info(name, $sformatf("APB MASTER DRIVER BFM"),UVM_LOW)
  end
 
  //-------------------------------------------------------
  // Task: wait_for_preset_n
  // Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();
    @(negedge preset_n);
    `uvm_info(name ,$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
 
    @(posedge preset_n);
    `uvm_info(name ,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
    //drive_idle_state();
  endtask: wait_for_preset_n
  
  //--------------------------------------------------------------------------------------------
  // Task: drive_to_bfm
  // This task will drive the data from bfm to proxy using converters
  //
  // Parameters:
  // data_packet  - handle for apb_transfer_char_s
  // cfg_pkt      - handle for apb_transfer_cfg_s
  //--------------------------------------------------------------------------------------------
  task drive_to_bfm(inout apb_transfer_char_s data_packet, input apb_transfer_cfg_s cfg_packet);
    `uvm_info(name,$sformatf("data_packet=\n%p",data_packet),UVM_HIGH);
    `uvm_info(name,$sformatf("cfg_packet=\n%p",cfg_packet),UVM_HIGH);
    //if(preset_n) begin
      //@(posedge pclk);
      `uvm_info(name,$sformatf("DRIVE TO BFM TASK"),UVM_HIGH);

      //Driving Idle state
      //drive_idle_state();

      //Driving Setup state
      drive_setup_state(data_packet);

      //Driving Access state
      waiting_in_access_state(data_packet);

    //end
    //else begin
    //  `uvm_info(name,$sformatf("RESET_DETECTED"),UVM_HIGH);

    //  //Driving idle state
    //  drive_idle_state();
    //end
    // MSHA:@(posedge pclk);
    // MSHA:penable <= 0;
    // MSHA:paddr <= 'x;
    // MSHA:pwdata <= 'x;
    // MSHA:pwrite <='x;
    // MSHA:pstrb <= 'x;
    // MSHA:pprot <= 'x;
   endtask: drive_to_bfm

  //--------------------------------------------------------------------------------------------
  // Task: drive_idle_state
  // This task drives the apb interface to idle state
  //--------------------------------------------------------------------------------------------
  task drive_idle_state();
      @(posedge pclk);
      pselx   <= '0;
      penable <= 1'b0;
      `uvm_info(name,$sformatf("DROVE THE IDLE STATE"),UVM_HIGH)
  endtask: drive_idle_state

  //--------------------------------------------------------------------------------------------
  // Task: drive_setup_state
  // This task defines the setup phase where signals 
  // are set to drive
  //
  // Parameters:
  // paddr - address signal
  //--------------------------------------------------------------------------------------------
  task drive_setup_state(inout apb_transfer_char_s data_packet);
    //if(preset_n) begin
      @(posedge pclk);
      `uvm_info(name,$sformatf("DRIVING THE SETUP STATE"),UVM_HIGH)
      pselx   <= data_packet.pselx;
      penable <= 1'b0;
      paddr   <= data_packet.paddr;
      pwrite  <= data_packet.pwrite;
      if(data_packet.pwrite == WRITE) begin
        pwdata <= data_packet.pwdata;
        pstrb  <= data_packet.pstrb;
      end
      else begin
        pstrb <= '0;
      end
      pprot <= data_packet.pprot;
    //end
    //else begin
    //  `uvm_info(name,$sformatf("RESET_DETECTED"),UVM_HIGH);
    //  drive_idle_state();
    //end 
  endtask: drive_setup_state

  //-------------------------------------------------------
  // Task: drive_access_state
  // This task defines the accessing of data signals from master to slave or viceverse
  //
  // Parameters:
  // data_packet - handle for apb_transfer_char_s
  //-------------------------------------------------------
  task waiting_in_access_state(inout apb_transfer_char_s data_packet);
    //if(preset_n) begin
      @(posedge pclk);
      `uvm_info(name,$sformatf("INSIDE ACCESS STATE"),UVM_HIGH);

      //pselx     <= data_packet.pselx;
      penable   <= 1'b1;
      
      detect_wait_state(data_packet, penable);

      // MSHA:if(pready == 1'b1) begin
      // MSHA:  transfer_data(data_packet);
      // MSHA:end
      // MSHA:else begin
      // MSHA:  //Driving Wait State
      // MSHA:  detect_wait_state(data_packet, penable);
      // MSHA:end
      //if(end_of_transfer == 1'b1) begin
      //  drive_idle_state();
      //end
      //else begin
      //  drive_setup_state(data_packet);
      //end
    //end
    // MSHA:else begin
    // MSHA:  `uvm_info(name,$sformatf("RESET_DETECTED"),UVM_HIGH);
    // MSHA:  drive_idle_state();
    // MSHA:end

  endtask: waiting_in_access_state

  //--------------------------------------------------------------------------------------------
  // Task: transfer_data
  // This task makes apb to drive pwdata or sample prdata based on pwrite operation
  //
  // Parameters:
  // data_packet - handle for apb_transfer_char_s
  //--------------------------------------------------------------------------------------------
  task transfer_data(inout apb_transfer_char_s data_packet);
        
    `uvm_info(name,$sformatf("TRANSFER DATA"),UVM_HIGH);
    if(pwrite == 1'b1) begin
      pwdata <= data_packet.pwdata;
      //end_of_transfer = 1'b1;
    end
    else begin
      data_packet.prdata = prdata;
      //end_of_transfer = 1'b1;
    end

    //drive_idle_state();
  endtask :transfer_data

  //--------------------------------------------------------------------------------------------
  // Task: detect_wait_state
  // In this task, signals are waiting for pready to set to high to transfer the data_packet
  //
  // Parameters:
  // data_packet - handle for apb_transfer_char_s
  //--------------------------------------------------------------------------------------------
  task detect_wait_state(inout apb_transfer_char_s data_packet, bit penable);
    
    @(posedge pclk);
    `uvm_info(name,$sformatf("DETECT_WAIT_STATE"),UVM_HIGH);
    while(pready==0) begin
      `uvm_info(name,"WAIT_STATE_DETECTED",UVM_HIGH);
      @(posedge pclk);
      data_packet.no_of_wait_states++;
    end

    if(data_packet.pwrite == READ) begin
      data_packet.prdata = prdata;
    end

    data_packet.pslverr = pslverr;

    //paddr <= data_packet.paddr;
    //pwrite <= data_packet.pwrite;
    // MSHA:if(data_packet.pwrite == 1) begin
    // MSHA:  pwdata <= data_packet.pwdata;
    // MSHA:end
    //else begin
    //  data_packet.prdata = prdata;
    //end

    `uvm_info(name,$sformatf("DATA READY TO TRANSFER"),UVM_HIGH);
    // MSHA: transfer_data(data_packet);

  endtask : detect_wait_state

endinterface : apb_master_driver_bfm

`endif

