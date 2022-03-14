`ifndef APB_SLAVE_COVERAGE_INCLUDED_
`define APB_SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_coverage
//  This class is used to include covergroups and bins required for functional coverage
//--------------------------------------------------------------------------------------------
class apb_slave_coverage extends uvm_subscriber#(apb_slave_tx);
  `uvm_component_utils(apb_slave_coverage)

  //Variable: apb_slave_agent_cfg_h;
  //Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Covergroup : apb_slave_covergroup
  //  Covergroup consists of the various coverpoints
  //  based on the number of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup apb_slave_covergroup with function sample (apb_slave_agent_config cfg, apb_slave_tx packet);
  option.per_instance = 1;

  //Checking the signal coverage
  PWRITE_CP : coverpoint tx_type_e'(packet.pwrite) {
    option.comment = "read and write conditon based on pwrite";
    bins TRANSACTION_TYPE[] = {0,1};
  }

  PSELX_CP : coverpoint packet.psel {
    option.comment = "no.of slaves used ";
    bins NO_OF_SLAVES[] = {1};
  }

  PADDR_CP : coverpoint cfg.paddr {
    option.comment = "address range";
    bins addr[] = {[0:2**ADDRESS_WIDTH]};
  }

  PWDATA_CP : coverpoint packet.pwdata {
    option.comment = "write data range";
    bins WDATA_BIT[] = {[0:2**DATA_WIDTH]};
  }
  
  PRDATA_CP : coverpoint packet.prdata {
    option.comment = "read data range ";  
    bins RDATA_BIT[]  = {[0:2**DATA_WIDTH]};
  }

  PSLVERR_CP : coverpoint slave_error_e'(packet.pslverr) {
    option.comment = "error signal at the end of transfer";
    bins SLAVE_ERROR[] = {0,1};
  }

  //Cross coverage 
  PADDR_X_PWDATA_ : cross PADDR_CP,PWDATA_CP;
  PADDR_X_PRDATA_ : cross PADDR_CP,PRDATA_CP;

  endgroup : apb_slave_covergroup

  //-------------------------------------------------------
  //Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_coverage", uvm_component parent = null);
  extern virtual function void write(apb_slave_tx t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : apb_slave_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
// 
// Parameters:
//  name - apb_slave_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_coverage::new(string name = "apb_slave_coverage",uvm_component parent = null);
  super.new(name, parent);
  apb_slave_covergroup = new();
endfunction : new

//-------------------------------------------------------
// Function: write
//  Creates the write method
//
// Parameters:
//  t - apb_slave_tx handle
//-------------------------------------------------------
function void apb_slave_coverage::write(apb_slave_tx t);
  `uvm_info(get_type_name(),"APB SLAVE COVERAGE",UVM_LOW);
  apb_slave_covergroup.sample(apb_slave_agent_cfg_h,t);
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
//  Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void apb_slave_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Slave Agent Coverage = %0.2f %%", apb_slave_covergroup.get_coverage()), UVM_NONE);
endfunction : report_phase

`endif

