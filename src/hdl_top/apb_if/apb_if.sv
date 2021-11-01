`ifndef apb_IF_INCLUDED_
`define apb_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : apb_if
//  Declaration of pin level signals for apb interface
//--------------------------------------------------------------------------------------------
interface apb_if;
  output reg  psel;
  output reg  penable;    
  output reg  pwrite;
  output reg [7:0] paddr;
  output reg [7:0] pwdata;                     	
  input clk;   
  input rst;
  input [20:0] system_bus;      
  input [7:0] prdata;
  
  parameter IDLE = 2'd0, SETUP = 2'd1, ACCESS  = 2'd2;
  parameter READ= 2'd0, WRITE=2'd1;
  
  reg [1:0] state; 
  reg [7:0] pwdata1;
  reg [7:0] paddr1;
  reg penable1;

  reg [7:0] sys_data;
  reg [7:0] sys_addr;
  reg [1:0]  sys_kind;
  reg [ 1 : 0 ]sel slave;
  reg sys_active;     
 
`endif
