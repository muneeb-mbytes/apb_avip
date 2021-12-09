`ifndef APB_GLOBAL_PKG_INCLUDED_
`define APB_GLOBAL_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : apb_global_pkg
// Used for storing required enums, parameters and defines
//--------------------------------------------------------------------------------------------
package apb_global_pkg;

  //Parameter : NO_OF_SLAVES
  //Used to set number of slaves required
  parameter int NO_OF_SLAVES = 4;

  //Parameter : MASTER_AGENT_ACTIVE
  //Used to set the master agent either active or passive
  parameter bit MASTER_AGENT_ACTIVE = 1;

  //Parameter : SLAVE_AGENT_ACTIVE
  //Used to set the slave agent either active or passive
  parameter bit SLAVE_AGENT_ACTIVE = 1;

  //Parameter : MASTER_HAS_COVERAGE
  //Used to set the coverage if we need it in master
  //parameter bit MASTER_HAS_COVERAGE = 1;

  //Parameter : SLAVE_HAS_COVERAGE
  //Used to set the coverage if we need it in slave
  //parameter bit SLAVE_HAS_COVERAGE = 1;

  //Parameter : ADDRESS_WIDTH
  //Used to set the address width to the address bus
  //Maximum Value is 32
  parameter int ADDRESS_WIDTH = 32;

  //Parameter : DATA_WIDTH
  //Used to set the data width 
  //Maximum Value is 8
  parameter int DATA_WIDTH = 8;

  //Parameter : SLAVE_MEMORY_SIZE
  //Sets the memory size of the slave in KB
  parameter int SLAVE_MEMORY_SIZE = 12;

  //Parameter : SLAVE_MEMORY_GAP
  //Sets the memory gap size of the slave
  parameter int SLAVE_MEMORY_GAP = 2;

  //Parameter : transfer_size
  //Used to declare the size of bits will be transferred
  //Maximum value is 32bits
  //parameter int TRANSFER_SIZE = 32;

  //Parameter : MAX_ADDR_RANGE
  //Used to set the maximum address range as 32 
  //parameter int MAX_ADDR_RANGE = 32;

  //Parameter : MIN_ADDR_RANGE
  //Used to set the minimum address range as 0 
  //parameter int MIN_ADDR_RANGE = 0;
  
  //-------------------------------------------------------
  // Enum : transfer_size_e
  // Used to declare enum type for all transfer sizes
  //-------------------------------------------------------
  typedef enum bit[31:0]{
    BIT_8   = 32'd8,
    BIT_16  = 32'd16,
    BIT_24  = 32'd24,
    BIT_32  = 32'd32
  }transfer_size_e;

  //-------------------------------------------------------
  // Enum : slave_error_e
  // Used to declare enum type for the pslverr
  //-------------------------------------------------------
  typedef enum bit{
    NO_ERROR    = 1'b0,
    ERROR       = 1'b1
  }slave_error_e;

  //-------------------------------------------------------
  // Enum : endian_e
  // Used to declare enum type for the endians
  //-------------------------------------------------------
  typedef enum bit{
    LITTL_ENDIAN    = 1'b0,
    BIG_ENDIAN      = 1'b1
  }endian_e;


  //-------------------------------------------------------
  // Enum : is_active_e
  // Used to declare enum type for the is_active
  //-------------------------------------------------------
  //typedef enum bit{
  //  IS_ACTIVE     = 1'b1,
  //  IS_PASSIVE    = 1'b0
  //}is_active_e;



  //-------------------------------------------------------
  // Enum : operation_states_e
  // Used to declare enum type for all the states used
  //-------------------------------------------------------
  //typedef enum bit[1:0] {
  //  IDLE_STATE    = 2'b00,
  //  SETUP_STATE   = 2'b01,
  //  ACCESS_STATE  = 2'b10 
  //}operation_states_e;

  //-------------------------------------------------------
  // Enum : tx_type_e 
  // Used to declare the type of transaction done
  //-------------------------------------------------------
  typedef enum bit {
    WRITE = 1,
    READ  = 0 
  }tx_type_e;  
  
  //-------------------------------------------------------
  // Enum : protection_type_e 
  // Used to declare the type ofprotection of the 
  // transaction
  //-------------------------------------------------------
  typedef enum logic[2:0]{
    NORMAL_SECURE_DATA              = 3'b000,
    NORMAL_SECURE_INSTRUCTION       = 3'b001,
    NORMAL_NONSECURE_DATA           = 3'b010,
    NORMAL_NONSECURE_INSTRUCTION    = 3'b011,
    PRIVILEGED_SECURE_DATA          = 3'b100,
    PRIVILEGED_SECURE_INSTRUCTION   = 3'b101,
    PRIVILEGED_NONSECURE_DATA       = 3'b110,
    PRIVILEGED_NONSECURE_INSTUCTION = 3'b111
    }protection_type_e;

  //-------------------------------------------------------
  // Enum : slave_no_e
  // Used to declare the slave number by assigning the value for encoding
  //-------------------------------------------------------
  typedef enum bit [15:0] {
    SLAVE_0  = 16'b0000000000000001,
    SLAVE_1  = 16'b0000000000000010,
    SLAVE_2  = 16'b0000000000000100,
    SLAVE_3  = 16'b0000000000001000,
    SLAVE_4  = 16'b0000000000010000,
    SLAVE_5  = 16'b0000000000100000,
    SLAVE_6  = 16'b0000000001000000,
    SLAVE_7  = 16'b0000000010000000,
    SLAVE_8  = 16'b0000000100000000,
    SLAVE_9  = 16'b0000001000000000,
    SLAVE_10 = 16'b0000010000000000,
    SLAVE_11 = 16'b0000100000000000,
    SLAVE_12 = 16'b0001000000000000,
    SLAVE_13 = 16'b0010000000000000,
    SLAVE_14 = 16'b0100000000000000,
    SLAVE_15 = 16'b1000000000000000
  }slave_no_e;

  //-------------------------------------------------------
  // Struct : apb_transfer_char_s
  //This struct datatype consists of all signals which 
  //are used for seq item conversion
  //-------------------------------------------------------
  typedef struct {
    bit pwrite;
    bit pslverr;
    bit [2:0] pprot;
    bit [NO_OF_SLAVES-1:0] pselx;
    bit [(DATA_WIDTH/8)-1:0] pstrb;
    bit [DATA_WIDTH-1:0] prdata;
    bit [ADDRESS_WIDTH-1:0] paddr; 
    bit [DATA_WIDTH-1:0] pwdata;
    int no_of_wait_states;
  }apb_transfer_char_s;
  
  //-------------------------------------------------------
  // Struct : apb_cfg_char_s
  //This struct datatype consists of all configurations
  //which are used for seq item conversion
  //-------------------------------------------------------
  typedef struct{
    bit [ADDRESS_WIDTH-1:0]min_address;
    bit [ADDRESS_WIDTH-1:0]max_address;
    bit [ADDRESS_WIDTH-1:0]paddr;
  }apb_transfer_cfg_s;

  //-------------------------------------------------------
  // Enum : slave_max_address
  // Used to declare the slave max address range for 
  // respective slave
  // 3 bits are given as memory gap bwtween eaxh slave
  //-------------------------------------------------------
  //typedef enum bit[237:0] {
  //  S0 = 238'd12,
  //  S1 = 238'd27,
  //  S2 = 238'd42,
  //  S3 = 238'd57,
  //  S4 = 238'd72,
  //  S5 = 238'd87,
  //  S6 = 238'd102,
  //  S7 = 238'd117,
  //  S8 = 238'd132,
  //  S9 = 238'd147,
  //  S10 = 238'd2382,
  //  S11 = 238'd177,
  //  S12 = 238'd192,
  //  S13 = 238'd207,
  //  S14 = 238'd222,
  //  S15 = 238'd237
  //}slave_max_addr_e;

  //-------------------------------------------------------
  // Enum : slave_min_address
  // Used to declare the slave min address range for 
  // respective slave
  //-------------------------------------------------------
  //typedef enum bit[237:0] {
  //  S_MIN_0 = 238'd0,
  //  S_MIN_1 = 238'd16,
  //  S_MIN_2 = 238'd31,
  //  S_MIN_3 = 238'd46,
  //  S_MIN_4 = 238'd61,
  //  S_MIN_5 = 238'd76,
  //  S_MIN_6 = 238'd91,
  //  S_MIN_7 = 238'd106,
  //  S_MIN_8 = 238'd121,
  //  S_MIN_9 = 238'd136,
  //  S_MIN_10 = 238'd2151,
  //  S_MIN_11 = 238'd166,
  //  S_MIN_12 = 238'd181,
  //  S_MIN_13 = 238'd196,
  //  S_MIN_14 = 238'd211,
  //  S_MIN_15 = 238'd2226
  //}slave_min_addr_e;
  
endpackage : apb_global_pkg

`endif

