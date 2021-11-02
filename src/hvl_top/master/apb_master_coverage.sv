`ifndef APB_MASTER_COVERAGE_INCLUDED_
`define APB_MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_coverage
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_master_coverage extends uvm_subscriber #(apb_master_tx);
  `uvm_component_utils(apb_master_coverage)
 
  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  apb_master_agent_config apb_master_agent_cfg_h;
  
  //Creating handle for apb_master transacion coverage
  apb_master_tx apb_master_tx_cov_data;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(apb_master_tx apb_master_tx_h)
  extern virtual function report_phase(uvm_phase phase);

endclass : apb_master_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - apb_master_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_master_coverage::new(string name = "apb_master_coverage", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void apb_master_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_master_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "apb_master_coverage");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase
*/

//--------------------------------------------------------------------------------------------
// Function: write
// // TODO(mshariff): Add comments
//--------------------------------------------------------------------------------------------
function void apb_master_coverage::write(apb_master_tx apb_master_tx_cov_data)
  // TODO(mshariff): 
  // cg.sample(master_agent_cfg_h, master_tx_cov_data);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function apb_master_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformat("APB Master Agent Coverage = %0.2f %%",
                                       apb_master_cg.get_inst_coverage()), UVM_NONE);
endfunction: report_phase

`endif

