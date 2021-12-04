`ifndef APB_8B_TEST_INCLUDED_
`define APB_8B_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_8b_test
// Extends the base test and starts the virtual sequence of 8 bit
//--------------------------------------------------------------------------------------------
class apb_8b_test extends apb_base_test;
  `uvm_component_utils(apb_8b_test)
  
  //Variable : apb_virtual_8b_seq_h'
  //Instatiation of apb_virtual_8b_seq
  apb_virtual_8b_seq apb_virtual_8b_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_8b_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_8b_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_8b_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_8b_test::new(string name = "apb_8b_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Creates the apb_virtual_8b_seq sequnce and starts the 8b virtual sequences
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_8b_test::run_phase(uvm_phase phase);
  
  super.run_phase(phase);
  apb_virtual_8b_seq_h = apb_virtual_8b_seq::type_id::create("apb_virtual_8b_seq_h");
  `uvm_info(get_type_name(),$sformatf("apb_8b_test"),UVM_LOW);
  phase.raise_objection(this);
    apb_virtual_8b_seq_h.start(apb_env_h.apb_virtual_seqr_h);
  phase.drop_objection(this);

endtask : run_phase

`endif


