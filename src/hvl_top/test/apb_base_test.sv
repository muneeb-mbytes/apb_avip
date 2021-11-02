`ifndef APB_BASE_TEST_INCLUDED_
`define APB_BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_base_test
// Base test has the testcase scenarios for the tesbench
// Env and Config are created in apb_base_test
// Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class apb_base_test extends uvm_test;
  `uvm_component_utils(apb_base_test)
  
  //Variable : env_h
  //Declaring a handle for env
  apb_env apb_env_h;

  //Variable : apb_env_cfg_h
  //Declaring a handle for env_cfg_h
  apb_env_config apb_env_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setup_apb_env_config();
  extern virtual function void setup_apb_master_agent_config();
  extern virtual function void setup_apb_slave_agent_config();
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : apb_base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_base_test::new(string name = "apb_base_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates env and required configuarions
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  setup_apb_env_config();
  apb_env_h = apb_env::type_id::create("apb_env",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function : setup_apb_env_config
// It calls the master agent config setup and slave agent config steup functions
//--------------------------------------------------------------------------------------------
function void apb_base_test::setup_apb_env_config();
  apb_env_cfg_h = apb_env_config::type_id::create("apb_env_cfg_h");
  apb_env_cfg_h.no_of_slaves      = NO_OF_SLAVES;
  apb_env_cfg_h.has_scoreboard    = 1;
  apb_env_cfg_h.has_virtual_seqr  = 1;
  setup_apb_master_agent_config();
  setup_apb_slave_agent_config();
endfunction : setup_apb_env_config

//--------------------------------------------------------------------------------------------
// Function : setup_apb_master_agent_config
// Sets the configurations to the corresponding variables in apb master agent config
// Creates the master agent config
// Sets apb master agent config into configdb 
//--------------------------------------------------------------------------------------------
function void apb_base_test::setup_apb_master_agent_config();
  apb_env_cfg_h.apb_master_agent_cfg_h = apb_master_agent_config::type_id::create("apb_master_agent_config");
  if(MASTER_AGENT_ACTIVE === 1) begin
    apb_env_cfg_h.apb_master_agent_cfg_h.is_active    = uvm_active_passive_enum'(UVM_ACTIVE);
  end
  else begin
    apb_env_cfg_h.apb_master_agent_cfg_h.is_active    = uvm_active_passive_enum'(UVM_PASSIVE);
  end
  apb_env_cfg_h.apb_master_agent_cfg_h.no_of_slaves   = NO_OF_SLAVES;

  uvm_config_db#(apb_master_agent_config)::set(this,"*master_agent*","apb_master_agent_config",apb_env_cfg_h.apb_master_agent_cfg_h);

endfunction : setup_apb_master_agent_config

//--------------------------------------------------------------------------------------------
// Function : setup_apb_slave_agent_config
// It calls the master agent config setup and slave agent config steup functions
//--------------------------------------------------------------------------------------------
function void apb_base_test::setup_apb_slave_agent_config();
  apb_env_cfg_h.apb_slave_agent_cfg_h = new[apb_env_cfg_h.no_of_slaves];
  foreach(apb_env_cfg_h.apb_slave_agent_cfg_h[i]) begin
    apb_env_cfg_h.apb_slave_agent_cfg_h[i] =
    apb_slave_agent_config::type_id::create($sformatf("apb_slave_agent_config[%0d]",i));
    apb_env_cfg_h.apb_slave_agent_cfg_h[i].slave_id = i;
    if(SLAVE_AGENT_ACTIVE === 1) begin
      apb_env_cfg_h.apb_slave_agent_cfg_h[i].is_active = uvm_active_passive_enum'(UVM_ACTIVE);
    end
    else begin
      apb_env_cfg_h.apb_slave_agent_cfg_h[i].is_active = uvm_active_passive_enum'(UVM_PASSIVE);
    end
    uvm_config_db #(apb_slave_agent_config)::set(this,$sformatf("*slave_agent*[%0d]",i),"apb_slave_agent_config", apb_env_cfg_h.apb_slave_agent_cfg_h[i]);
  end
endfunction : setup_apb_slave_agent_config


//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_base_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_base_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_base_test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this, "apb_base_test");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

