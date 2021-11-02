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
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to 
  // this apb_master over SPI interface
  int no_of_slaves;

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_agent_config");

endclass : apb_master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_agent_config
//--------------------------------------------------------------------------------------------
function apb_master_agent_config::new(string name = "apb_master_agent_config");
  super.new(name);
endfunction : new

`endif

