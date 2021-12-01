`ifndef APB_IF_INCLUDED_
`define APB_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : apb_if
//  Declaration of pin level signals for apb interface
//--------------------------------------------------------------------------------------------
import apb_global_pkg::*;

interface apb_if(input pclk, input presetn);
  logic  [NO_OF_SLAVES-1:0]pselx;
  logic  penable;    
  logic  pwrite;
  logic [ADDRESS_WIDTH-1:0] paddr;
  logic [DATA_WIDTH-1:0] pwdata;                     	
  logic [(DATA_WIDTH/8)-1:0] pstrb;                     	
  logic [2:0]pprot; 
  logic [DATA_WIDTH-1:0] prdata;
  logic pready;
  logic pslverr;
  /*
  parameter IDLE = 2'd0, SETUP = 2'd1, ACCESS  = 2'd2;
  parameter READ= 2'd0, WRITE=2'd1;
  
  logic [1:0] state; 
  logic [7:0] pwdata1;
  logic [7:0] paddr1;
  logic penable1;

  logic [7:0] sys_data;
  logic [7:0] sys_addr;
  logic [1:0]  sys_kind;
  logic [ 1 : 0 ]sel slave;
  logic sys_active;*/ 
endinterface : apb_if
 
`endif
