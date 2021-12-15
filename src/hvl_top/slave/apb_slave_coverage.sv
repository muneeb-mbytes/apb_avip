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
  // Covergroup consists of the various coverpoints
  // based on the number of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup apb_slave_covergroup with function sample (apb_slave_agent_config cfg, apb_slave_tx packet);
  option.per_instance = 1;

  //cheking the signal coverage
  PWRITE_CP:coverpoint tx_cov.pwrite {
    option.comment = "read and write conditon based on pwrite";
    bins read = {0};
    bins write = {1};
  }
//  PENABLE_CP:coverpoint tx_cov.penable {
//    option.comment = "setup and access based on the enable";
//    bins setup  = {0};
//    bins access = {1};
//  }

  PSELX_CP: coverpoint tx_cov.psel {
    option.comment = "no.of slaves used ";
    bins NO_OF_SLAVES[] = {[15:0]};
  }

  PADDR_CP : coverpoint tx_cov.paddr {
    option.comment = "address range";
    bins addr = {[31:8]};
  }

  PWDATA_CP: coverpoint tx_cov.pwdata {
    option.comment = "write data range";
    bins wdata_8bit = {8};
    bins wdata_16bit = {16};
    bins wdata_24bit = {24};
    bins wdata_32bit = {32};

  }
  PRDATA_CP : coverpoint tx_cov.prdata {
    option.comment = "read data range ";  
    bins wdata_8bit = {8};
    bins wdata_16bit = {16};
    bins wdata_24bit = {24};
    bins wdata_32bit = {32};

  }

  PSLVERR_CP:coverpoint tx_cov.pslverr {
    option.comment = "error signal at the end of transfer";
    bins err = {1};
    bins ok = {0};
  }

 //  PSTRB_CP :  coverpoint tx_cov.pstrb {
 //   option.comment = "error signal at the end of transfer";
 // bins strb = {[3:0]};
 // }
 //cross coverage 
  PADDR_X_PWDATA_ : cross PADDR_CP,PWDATA_CP;
 // PSEL_X_PENABLE_ : cross PSEL_CP,PENABLE_CP;
  PADDR_X_PRDATA_ : cross PADDR_CP,PRDATA_CP;

endgroup : apb_slave_covergroup
//-------------------------------------------------------
//Externally defined tasks and functions
//-------------------------------------------------------
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
 // apb_slave_cover_group = new();
endfunction : new

//-------------------------------------------------------
//Constructor: write
//Parameters:
//Creates the write method
//-------------------------------------------------------
function void apb_slave_coverage::write(apb_slave_tx t);
  `uvm_info(get_type_name(),"APB SLAVE COVERAGE",UVM_LOW);
  apb_slave_covergroup.sample(apb_slave_agent_cfg_h,t);
endfunction: write

`endif
