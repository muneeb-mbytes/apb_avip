`ifndef APB_SLAVE_COVERAGE_INCLUDED_
`define APB_SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_slave_coverage
//  This class is used to include covergroups and bins required for functional coverage
//--------------------------------------------------------------------------------------------
class apb_slave_coverage extends uvm_subscriber#(apb_slave_tx);
  `uvm_component_utils(apb_slave_coverage)

  // Variable: apb_slave_agent_cfg_h;
  // Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  // Variable: apb_slave_analysis_export
  //declaring analysis port for coverage
  uvm_analysis_port #(apb_slave_tx)apb_slave_analysis_export;

  //creating handle for slave transaction coverage
 //apb_slave_tx apb_slave_tx_h;

  extern function new(string name = "apb_slave_coverage", uvm_component parent = null);
  extern virtual function void write(apb_slave_tx t);

endclass : apb_slave_coverage

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Parameters:
//  name - apb_slave_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_coverage::new(string name = "apb_slave_coverage",uvm_component parent = null);
  super.new(name, parent);
  apb_slave_analysis_export = new("apb_slave_analysis_export",this);
endfunction : new

//-------------------------------------------------------
// 
//-------------------------------------------------------
function void apb_slave_coverage::write(apb_slave_tx t);
  `uvm_info(get_type_name(),"APB SLAVE COVERAGE",UVM_LOW);
endfunction: write

`endif
