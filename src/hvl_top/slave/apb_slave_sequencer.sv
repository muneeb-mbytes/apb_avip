`ifndef APB_SLAVE_SEQUENCER_INCLUDED_
`define APB_SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_sequencer
//  It send transactions to driver via tlm ports
//--------------------------------------------------------------------------------------------
class apb_slave_sequencer extends uvm_sequencer#(apb_slave_tx);
  `uvm_component_utils(apb_slave_sequencer)
  
  //Variable: apb_slave_agent_cfg_h;
  //Handle for  apb slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_sequencer", uvm_component parent = null);
  
endclass : apb_slave_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//  apb_slave_sequencer class object is initialized
//
// Parameters:
//  name - apb_slave_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_sequencer::new(string name = "apb_slave_sequencer",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif

