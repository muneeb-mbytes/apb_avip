`ifndef APB_SLAVE_AGENT_CONFIG_INCLUDED_
`define APB_SLAVE_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_slave_agent_config
//  Used as the configuration class for slave agent and it's components
//--------------------------------------------------------------------------------------------
class apb_slave_agent_config extends uvm_object;
  
  `uvm_object_utils(apb_slave_agent_config) 
  
  //Variable: is_active
  //Used to declare whether the agent is active or passive
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  //Variable: slave_id
  //Gives the slave id
  int slave_id;
  
  //Variable : has_coverage
  //Used to set whether we need to create coverage or not
  bit has_coverage;

  //variable : slave_mem
  //Declaration of slave_memory to store the data from master
  bit [DATA_WIDTH-1:0]slave_mem[ADDRESS_WIDTH-1:0];
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_agent_config");
  extern function void do_print(uvm_printer printer);

endclass : apb_slave_agent_config

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - apb_slave_agent_config
//--------------------------------------------------------------------------------------------
function apb_slave_agent_config::new(string name = "apb_slave_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void apb_slave_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field ("is_active",is_active,1, UVM_DEC);
  printer.print_field ("slave_id",slave_id,2, UVM_DEC);
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  
endfunction : do_print

`endif
