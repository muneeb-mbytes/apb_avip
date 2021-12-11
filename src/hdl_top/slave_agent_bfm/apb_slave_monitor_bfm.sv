`ifndef APB_SLAVE_MONITOR_BFM_INCLUDED_
`define APB_SLAVE_MONITOR_BFM_INCLUDED_

//-------------------------------------------------------
// Importing apb global package
//-------------------------------------------------------
import apb_global_pkg::*;

//--------------------------------------------------------------------------------------------
// Inteface: apb_slave_monitor_bfm
//  Connects the slave monitor bfm with the monitor proxy 
//  to call the tasks and functions from apb monitor bfm to apb monitor proxy
//--------------------------------------------------------------------------------------------
interface apb_slave_monitor_bfm (input bit pclk,
                                 input bit preset_n,
                                 input bit [2:0]pprot,
                                 input bit pslverr,
                                 input bit pready,
                                 input logic penable,
                                 input logic pwrite,
                                 input logic psel,
                                 input logic [ADDRESS_WIDTH-1:0] paddr,
                                 input logic [DATA_WIDTH-1:0] pwdata,
                                 input logic [(DATA_WIDTH/8)-1:0] pstrb, 
                                 input logic [DATA_WIDTH-1:0] prdata
                               );
  
  //-------------------------------------------------------
  // Importing uvm_pkg file and apb_slave_pkg file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import apb_slave_pkg::apb_slave_monitor_proxy;

  // Variable: apb_slave_mon_proxy_h
  // Declaring handle for apb_slave_monitor_proxy
  apb_slave_monitor_proxy apb_slave_mon_proxy_h;
  
  // Variable: name
  // Assigning the string used in infos
  string name = "APB_SLAVE_MONITOR_BFM"; 
 
  initial begin
    `uvm_info(name, $sformatf("APB_SLAVE_MONITOR_BFM"), UVM_LOW);
  end

  //-------------------------------------------------------
  // Task: wait_for_preset_n
  //  Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_preset_n();
    @(negedge preset_n);
    `uvm_info(name, $sformatf("SYSTEM_RESET_DETECTED"), UVM_HIGH)
    
    @(posedge preset_n);
    `uvm_info(name, $sformatf("SYSTEM_RESET_DEACTIVATED"), UVM_HIGH)
  endtask : wait_for_preset_n

  //-------------------------------------------------------
  // Task: sample_data
  //  In this task, the pwdata and prdata is sampled
  //
  // Parameters: 
  //  apb_data_packet - Handle for apb_transfer_char_s class
  //  apb_cfg_packet  - Handle for apb_transfer_cfg_s class
  //-------------------------------------------------------
  task sample_data (output apb_transfer_char_s apb_data_packet, input apb_transfer_cfg_s apb_cfg_packet);
    @(negedge pclk);
    
    while(penable != 1) begin
      @(posedge pclk);
      `uvm_info(name, $sformatf("Inside while loop"), UVM_HIGH)
    end
    
    `uvm_info(name, $sformatf("SAHA_DEBUG: penable =%0d, pready=%0d, psel=%0d ", penable, pready, psel), UVM_HIGH)
    if (penable==1 && pready==1 && psel==1) begin
      apb_data_packet.pslverr = pslverr;
      apb_data_packet.pprot   = pprot;
      apb_data_packet.pwrite  = pwrite;
      apb_data_packet.paddr   = paddr;

      if (pwrite == WRITE) begin
        apb_data_packet.pwdata = pwdata;
        apb_data_packet.pstrb = pstrb;
      end
      else begin
        apb_data_packet.prdata = prdata;
      end
    end
    `uvm_info(name, $sformatf("SLAVE_SAMPLE_DATA=%p", apb_data_packet), UVM_HIGH)
  endtask : sample_data

endinterface : apb_slave_monitor_bfm

`endif

