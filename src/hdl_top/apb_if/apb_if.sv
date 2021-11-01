`ifndef APB_IF_INCLUDED_
`define APB_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : apb_if
//  Declaration of pin level signals for apb interface
//--------------------------------------------------------------------------------------------
interface apb_if;
  /*logic  psel;
  logic  penable;    
  logic  pwrite;
  logic [7:0] paddr;
  logic [7:0] pwdata;                     	
  logic clk;   
  logic rst;
  logic [20:0] system_bus;      
  logic [7:0] prdata;
  
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
