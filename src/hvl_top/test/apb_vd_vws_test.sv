`ifndef APB_VD_VWS_TEST_INCLUDED_
`define APB_VD_VWS_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_vd_vws_test
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_vd_vws_test extends apb_base_test;
  `uvm_component_utils(apb_vd_vws_test)
  
  apb_virtual_vd_vws_seq apb_virtual_vd_vws_seq_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_vd_vws_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_vd_vws_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_vd_vws_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_vd_vws_test::new(string name = "apb_vd_vws_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_vd_vws_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_vd_vws_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_vd_vws_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_vd_vws_test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_vd_vws_test::run_phase(uvm_phase phase);

  super.run_phase(phase);
  apb_virtual_vd_vws_seq_h = apb_virtual_vd_vws_seq::type_id::create("apb_virtual_vd_vws_seq_h");
  //`uvm_info(get_type_name(),$sformatf("apb_vd_vws_test"),UVM_LOW);
  phase.raise_objection(this);
    apb_virtual_vd_vws_seq_h.start(apb_env_h.apb_virtual_seqr_h);
  phase.drop_objection(this);

endtask : run_phase


`endif

