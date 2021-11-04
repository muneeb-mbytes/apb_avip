`ifndef APB_MASTER_AGENT_CONFIG_INCLUDED_
`define APB_MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_agent_config
// Used as the configuration class for apb_master agent, for configuring number of slaves and number
// of active passive agents to be created
//--------------------------------------------------------------------------------------------
class apb_master_agent_config extends uvm_object;
  `uvm_object_utils(apb_master_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active = UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to this apb_master over APB interface
  int no_of_slaves;

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_agent_config");
  extern function void do_print(uvm_printer printer);

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

endfunction : do_print

`endif

