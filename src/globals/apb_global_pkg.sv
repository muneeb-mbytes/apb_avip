`ifndef APB_GLOBAL_PKG_INCLUDED_
`define APB_GLOBAL_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_global_pkg
// Used for storing required enums, parameters and defines
//--------------------------------------------------------------------------------------------
package apb_global_pkg;

  //Parameter : NO_OF_SLAVES
  //Used to set number of slaves required
  parameter int NO_OF_SLAVES = 1;

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

  //Parameter : ADDRESS_LENGTH
  //Used to set the address length to the address bus
  //Maximum Value is 32
  parameter int ADDRESS_LENGTH = 32;

  //Parameter : DATA_WIDTH
  //Used to set the data width 
  //Maximum Value is 32
  parameter int DATA_WIDTH = 64;

  //parameter : max_addr_range
  parameter int MAX_ADDR_RANGE = 32;

  //parameter : min_addr_range
  parameter int MIN_ADDR_RANGE = 32;

  //-------------------------------------------------------
  // enum : operation_stages
  //-------------------------------------------------------
  typedef enum bit[1:0] {
    IDLE_STATE = 2'b00,
    SETUP_STATE = 2'b01,
    ACCESS_STATE = 2'b10 } operation_states_e;

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

} apb_transfer_char_s;


endpackage : apb_global_pkg

`endif
