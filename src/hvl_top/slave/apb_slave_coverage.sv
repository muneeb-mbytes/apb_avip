`ifndef APB_SLAVE_COVERAGE_INCLUDED_
`define APB_SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_slave_coverage
//  This class is used to include covergroups and bins required for functional coverage
//--------------------------------------------------------------------------------------------
class apb_slave_coverage extends uvm_subscriber#(apb_slave_tx);
  `uvm_component_utils(apb_slave_coverage)

  //creating handle for slav tx coverage data
  apb_slave_tx tx_cov;

  // Variable: apb_slave_agent_cfg_h;
  // Handle for apb_slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  // Variable: apb_slave_analysis_export
  //declaring analysis port for coverage
  uvm_analysis_port #(apb_slave_tx)apb_slave_analysis_export;

  //creating handle for slave transaction coverage
  //apb_slave_tx apb_slave_tx_h;
 
  //-------------------------------------------------------
  // Covergroup 
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup apb_slave_covergroup with function sample (apb_slave_agent_config cfg, apb_slave_tx packet);
  option.per_instance = 1;

  //cheking the signal coverage
  PWRITE_CP:coverpoint    pwrite {
    option.comment = "read and write conditon based on pwrite"
    bins read = {0};
    bins write = {1};
    }
  PENABLE_CP:coverpoint penable {
    option.commemt = "setup and access based on the enable"
    bins setup  = {0};
    bins access = {1};
  }

  PSELX_CP: coverpoint pselx {
  option.comment = "no.of slaves used "
  bins NO_OF_SLAVES[] = {[15:0]};
  }

  PADDR_CP : coverpoint paddr {
    option.comment = "address range"
    bins addr = {[31:8]};
  }

  PWDATA_CP: coverpoint pwdata {
  option.comment = "write data range"
  bins wdata = {[31:8]};
  }
 PRDATA_CP : coverpoint prdata {
 option.comment = "read data range "  
 bins pread = {[31:8]};
 }

  PSLVERR_CP:coverpoint pslverr {
    option.comment = "error signal at the end of transfer"
    bins err = {1};
    bins ok = {0};
    }
  PSTROB_CP :  coverpoint pstrob {
  option.comment = "error signal at the end of transfer"
  bins strob = {[3:0]};
  }
//cross coverage 
PADDR_X_PWDATA_: cross PADDR_CP,PWDATA_CP;
PSEL_X_PENABLE_: cross PSEL_CP,PENABLE_CP;
PADDR_X_PRDATA_: cross PADDR_CP,PRDATA_CP;

  endgroup : apb_slave_covergroup

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
