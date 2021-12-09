`ifndef APB_16B_WRITE_TEST_INCLUDED_
`define APB_16B_WRITE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_16b_write_test
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_16b_write_test extends apb_base_test;
  `uvm_component_utils(apb_16b_write_test)
  
  apb_virtual_16b_write_seq apb_virtual_16b_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_16b_write_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_16b_write_test


//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_16b_write_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_16b_write_test::new(string name = "apb_16b_write_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_16b_write_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_16b_write_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_16b_write_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_16b_write_test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_16b_write_test::run_phase(uvm_phase phase);
  
  super.run_phase(phase);
  apb_virtual_16b_seq_h = apb_virtual_16b_write_seq::type_id::create("apb_virtual_16b_seq_h");
  `uvm_info(get_type_name(),$sformatf("apb_16b_write_test"),UVM_LOW);
  phase.raise_objection(this);
    apb_virtual_16b_seq_h.start(apb_env_h.apb_virtual_seqr_h);
  phase.drop_objection(this);

endtask : run_phase


`endif

