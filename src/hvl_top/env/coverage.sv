`ifndef COVERAGE_INCLUDED_
`define COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: coverage
// Checks whether all the cases are covered or not
//--------------------------------------------------------------------------------------------
class coverage extends uvm_component;
  `uvm_component_utils(coverage)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function coverage::new(string name = "coverage",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds the analysis import
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "coverage");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

