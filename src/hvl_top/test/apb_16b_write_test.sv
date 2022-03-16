`ifndef APB_16B_WRITE_TEST_INCLUDED_
`define APB_16B_WRITE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_16b_write_test
//  Extends the base test and starts the virtual sequence of 16 bit
//--------------------------------------------------------------------------------------------
class apb_16b_write_test extends apb_base_test;
  `uvm_component_utils(apb_16b_write_test)
  
  //Variable: apb_virtual_16b_seq_h
  //Instatiation of apb_virtual_16b_seq
  apb_virtual_16b_write_seq apb_virtual_16b_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_16b_write_test", uvm_component parent = null);
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
// Task: run_phase
//  Creates the apb_virtual_16b_seq sequence and starts the 16b virtual sequences
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

