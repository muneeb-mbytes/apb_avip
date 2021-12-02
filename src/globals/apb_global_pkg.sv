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

  //Parameter : ADDRESS_WIDTH
  //Used to set the address width to the address bus
  //Maximum Value is 32
  parameter int ADDRESS_WIDTH = 32;

  //Parameter : DATA_WIDTH
  //Used to set the data width 
  //Maximum Value is 32
  parameter int DATA_WIDTH = 32;

  //Parameter : MAX_ADDR_RANGE
  //Used to set the maximum address range as 32 
  parameter int MAX_ADDR_RANGE = 32;

  //Parameter : MIN_ADDR_RANGE
  //Used to set the minimum address range as 0 
  parameter int MIN_ADDR_RANGE = 0;

  //-------------------------------------------------------
  // Enum : operation_states_e
  // Used to declare enum type for all the states used
  //-------------------------------------------------------
  typedef enum bit[1:0] {
    IDLE_STATE = 2'b00,
    SETUP_STATE = 2'b01,
    ACCESS_STATE = 2'b10 
  } operation_states_e;

  //-------------------------------------------------------
  // Enum : tx_type_e 
  // Used to declare the type of transaction done
  //-------------------------------------------------------
  typedef enum bit {
    WRITE = 1,
    READ  = 0 
  } tx_type_e;

  //-------------------------------------------------------
  // Enum : slave_no_e
  // Used to declare the slave number by assigning the value for encoding
  //-------------------------------------------------------
  typedef enum bit [3:1] {
    SLAVE_1 = 3'b001,
    SLAVE_2 = 3'b010,
    SLAVE_3 = 3'b100
  } slave_no_e;

  //-------------------------------------------------------
  // Struct : apb_transfer_char_s
  //This struct datatype consists of all signals which are used for seq item conversion
  //-------------------------------------------------------
  typedef struct {
    bit penable;
    bit pwrite;
    bit pslverr;
    bit pready;
    bit [2:0] pprot;
    bit [NO_OF_SLAVES-1:0] pselx;
    bit [(DATA_WIDTH/8)-1:0] pstrb;
    bit [DATA_WIDTH-1:0] prdata;
    bit [ADDRESS_WIDTH-1:0] paddr; 
    bit [DATA_WIDTH-1:0] pwdata;
  } apb_transfer_char_s;
  
  typedef struct{
    bit [ADDRESS_WIDTH-1:0] paddr;
  } apb_transfer_cfg_s;

endpackage : apb_global_pkg

`endif

