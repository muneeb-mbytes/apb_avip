`ifndef APB_VD_VWS_TEST_INCLUDED_
`define APB_VD_VWS_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_vd_vws_test
//  This test extends from the base test.
//  This test starts the variable data and variable wait state virtual sequence.
//--------------------------------------------------------------------------------------------
class apb_vd_vws_test extends apb_base_test;
  `uvm_component_utils(apb_vd_vws_test)
  
  //Variable: apb_virtual_vd_vws_seq_h;
  //Instatiation of apb_virtual_vd_vws_sequence.
  apb_virtual_vd_vws_seq apb_virtual_vd_vws_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_vd_vws_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_vd_vws_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_vd_vws_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_vd_vws_test::new(string name = "apb_vd_vws_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Creating the apb_virtual_vd_vws_seq and starting the same sequence.
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_vd_vws_test::run_phase(uvm_phase phase);

  super.run_phase(phase);
  apb_virtual_vd_vws_seq_h = apb_virtual_vd_vws_seq::type_id::create("apb_virtual_vd_vws_seq_h");
  phase.raise_objection(this);
    apb_virtual_vd_vws_seq_h.start(apb_env_h.apb_virtual_seqr_h);
  phase.drop_objection(this);

endtask : run_phase

`endif

