`ifndef APB_MASTER_AGENT_CONFIG_INCLUDED_
`define APB_MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_agent_config
// Used as the configuration class for apb_master agent, for configuring number of slaves and number
// of active passive agents to be created
//--------------------------------------------------------------------------------------------
class apb_master_agent_config extends uvm_object;
  `uvm_object_utils(apb_master_agent_config)

  //Variable: is_active
  //Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active = UVM_ACTIVE;  

  //Variable: no_of_slaves
  //Used for specifying the number of slaves connected to this apb_master over APB interface
  int no_of_slaves;

  //Variable: has_coverage
  //Used for enabling the master agent coverage
  bit has_coverage;

  //Variable: master_memory
  //Memory decleration for master to store the data of each slave
  //bit [DATA_WIDTH-1:0]master_memory[NO_OF_SLAVES*ADDRESS_WIDTH-1:0];

  bit [ADDRESS_WIDTH-1:0]paddr;

  //Variable: slave_no
  //Used to indicate the slave number
  //slave_no_e slave_no;
  
  //Declaring address ranges for 16 slaves
  // ommitting 7 address locations for memory gap between each slave
  /*bit [DATA_WIDTH-1:0] slave_1  [63:0]; 
  bit [DATA_WIDTH-1:0] slave_2  [133:70];
  bit [DATA_WIDTH-1:0] slave_3  [203:140];
  bit [DATA_WIDTH-1:0] slave_4  [273:210];
  bit [DATA_WIDTH-1:0] slave_5  [343:280];
  bit [DATA_WIDTH-1:0] slave_6  [413:350];
  bit [DATA_WIDTH-1:0] slave_7  [483:420];
  bit [DATA_WIDTH-1:0] slave_8  [553:490];
  bit [DATA_WIDTH-1:0] slave_9  [623:560];
  bit [DATA_WIDTH-1:0] slave_10 [693:630];
  bit [DATA_WIDTH-1:0] slave_11 [763:700];
  bit [DATA_WIDTH-1:0] slave_12 [833:770];
  bit [DATA_WIDTH-1:0] slave_13 [903:840];
  bit [DATA_WIDTH-1:0] slave_14 [973:910];
  bit [DATA_WIDTH-1:0] slave_15 [1043:980];
  bit [DATA_WIDTH-1:0] slave_16 [1113:1050];*/

  //Variable : master_memory
  //Used to store all the data from the slaves
  bit [DATA_WIDTH-1:0]master_memory[289:0];

  //Variable : master_max_assry
  //An associative array used to store the max address ranges of every slave
  bit [DATA_WIDTH-1:0]master_max_array[int];

  //Variable : master_min_array
  //An associative array used to store the min address ranges of every slave
  bit [DATA_WIDTH-1:0]master_min_array[int];

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_agent_config");
  extern function void do_print(uvm_printer printer);
  extern function void mem_mapping_max(int i, bit [238:0]value);
  extern function void mem_mapping_min(int i, bit [238:0]value);

endclass : apb_master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes memory for new object
//
// Parameters:
//  name - apb_master_agent_config
//--------------------------------------------------------------------------------------------
function apb_master_agent_config::new(string name = "apb_master_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
// Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void apb_master_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field ("is_active",     is_active,    $bits(is_active),     UVM_DEC);
  printer.print_field ("has_coverage",  has_coverage, $bits(has_coverage),  UVM_DEC);
  printer.print_field ("no_of_slaves",  no_of_slaves, $bits(no_of_slaves),  UVM_DEC);
  foreach(master_max_array[i]) begin
    printer.print_field("master_max_array_index",i,$bits(i),UVM_DEC);
    printer.print_field("master_max_array_value",master_max_array[i],$bits(master_max_array[i]),UVM_DEC);
  end
  foreach(master_min_array[i]) begin
    printer.print_field("master_min_array_index",i,$bits(i),UVM_DEC);
    printer.print_field("master_min_array_value",master_min_array[i],$bits(master_min_array[i]),UVM_DEC);
  end

endfunction : do_print

function void apb_master_agent_config::mem_mapping_max(int i, bit [238:0]value);
  master_max_array[i] = value;
endfunction : mem_mapping_max

function void apb_master_agent_config::mem_mapping_min(int i, bit [238:0]value);
  master_min_array[i] = value;
endfunction : mem_mapping_min

`endif

