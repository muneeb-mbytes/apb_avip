`ifndef APB_GLOBAL_PKG_INCLUDED_
`define APB_GLOBAL_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_global_pkg
// Used for storing required enums, parameters and defines
//--------------------------------------------------------------------------------------------
package apb_global_pkg;

  //Parameter : NO_OF_SLAVES
  //Used to set number of slaves required
  parameter int NO_OF_SLAVES = 3;

  //Parameter : MASTER_AGENT_ACTIVE
  //Used to set the master agent either active or passive
  parameter MASTER_AGENT_ACTIVE = 1;

  //Parameter : SLAVE_AGENT_ACTIVE
  //Used to set the slave agent either active or passive
  parameter SLAVE_AGENT_ACTIVE = 1;

  //Parameter : MASTER_HAS_COVERAGE
  //Used to set the coverage if we need it in master
  parameter MASTER_HAS_COVERAGE = 1;

  //Parameter : SLAVE_HAS_COVERAGE
  //Used to set the coverage if we need it in slave
  parameter SLAVE_HAS_COVERAGE = 1;

  //Parameter : ADDRESS_WIDTH
  //Used to set the address width to the address bus
  //Maximum Value is 32
  parameter int ADDRESS_WIDTH = 32;

  //Parameter : DATA_WIDTH
  //Used to set the data width 
  //Maximum Value is 32
  parameter int DATA_WIDTH = 32;

  //parameter : max_addr_range
  parameter int MAX_ADDR_RANGE = 32;

  //parameter : min_addr_range
  parameter int MIN_ADDR_RANGE = 0;

  //-------------------------------------------------------
  // enum : operation_stages
  //-------------------------------------------------------
  typedef enum bit[1:0] {
    IDLE_STATE = 2'b00,
    SETUP_STATE = 2'b01,
    ACCESS_STATE = 2'b10 
  } operation_states_e;

  typedef enum bit {
    WRITE = 1,
    READ  = 0 
  } tx_type_e;

  typedef enum bit [3:1] {
    SLAVE_1 = 3'b001,
    SLAVE_2 = 3'b010,
    SLAVE_3 = 3'b100
  } slave_no_e;

/*
  //parameter : IDLE_STATE
  //Used to indicate no transfer(PSELx & PENABLE=0)
  parameter IDLE_STATE = 00;

  //parameter : SETUP_STATE
  //Used to indicate transfer(PSELx=1,PENABEL=0)
  parameter SETUP_STATE = 01;
  
  //parameter : ACCESS_STATE
  //Used to indicate repitetion of transfers
  parameter ACCESS_STATE = 10;
*/

//--------------------------------------------------------------------------------------------
// Struct: apb_transfer_char_s
//  This struct datatype consists of all signals which are used for seq item conversion
//--------------------------------------------------------------------------------------------
typedef struct {
  bit penable;
  bit pwrite;
  bit [2:0]pprot;
  bit pselx;
  bit [(DATA_WIDTH/8)-1:0] pstrb;
  bit pslverr;
  bit pready;
  bit [DATA_WIDTH-1:0] prdata;
  bit [ADDRESS_WIDTH-1:0] paddr;
  bit [DATA_WIDTH-1:0] pwdata;
} apb_transfer_char_s;


endpackage : apb_global_pkg

`endif
