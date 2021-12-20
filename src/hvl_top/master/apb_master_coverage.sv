`ifndef APB_MASTER_COVERAGE_INCLUDED_
`define APB_MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_coverage
// This class is used to include covergroups and bins required for functional coverage
//--------------------------------------------------------------------------------------------
class apb_master_coverage extends uvm_subscriber #(apb_master_tx);
  `uvm_component_utils(apb_master_coverage)
 
  // Variable: apb_master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  apb_master_agent_config apb_master_agent_cfg_h;
  
  // Variable: apb_master_analysis_export
  // Declaring analysis port for coverage
  //uvm_analysis_port #(apb_master_tx)apb_master_analysis_export;
  
  //-------------------------------------------------------
  // Covergroup: apb_master_covergroup
  // Covergroup consists of the various coverpoints based on
  // no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup apb_master_covergroup with function sample (apb_master_agent_config cfg, apb_master_tx packet);
    option.per_instance = 1;

   // To check the number slaves we used
   PSEL_CP : coverpoint slave_no_e'(packet.pselx) {
     option.comment = " psel of apb";
     bins APB_PSELX[] = {[0:NO_OF_SLAVES-1]};
   }

   // To check whether the apb has written into or read from all address ranges
   // PADDR_CP : coverpoint cfg.paddr.size()*ADDRESS_WIDTH {
   // option.comment = " apb address";
   // bins APB_PADDR[] = {[0:ADDRESS_WIDTH-1]};
   // }

   PADDR_CP : coverpoint cfg.paddr {
     option.comment = " apb address";
     bins APB_PADDR[] = {[0:ADDRESS_WIDTH-1]};
   }

   //To check whether the apb has done both read and write operations
   PWRITE_CP : coverpoint tx_type_e'(packet.pwrite) {
     option.comment = "apb write or read operation";
     bins READ_DATA = {0};
     bins WRITE_DATA = {1};
   }

   // To check whether the apb has covered all possible cases of data range
   // PWDATA_CP : coverpoint packet.pwdata.size()*DATA_WIDTH{
   //   option.comment = "apb write data";
   //   bins APB_WRIRE_DATA[] = {[0:DATA_WIDTH-1]};
   // }

   PWDATA_CP : coverpoint packet.pwdata {
     option.comment = "apb write data";
     bins APB_WRITE_DATA[] = {[0:DATA_WIDTH-1]};
   }

/*
   //To check whether the apb has any wait states or not
   PREADY_CP : coverpoint packet.pready{
     option.comment = "apb pready signal";
     bins APB_PREADY_WAIT = {0};
     bins APB_PREADY_NO_WAIT = {1};
   }
*/

   //To check whether the apb has covered all possible cases of data range
  // PRDATA_CP : coverpoint packet.prdata.size()*DATA_WIDTH{
  //   option.comment = "apb read data";
  //   bins APB_READ_DATA[] = {[0:DATA_WIDTH-1]};
  // }
  
  PRDATA_CP : coverpoint packet.prdata{
     option.comment = "apb read data";
     bins APB_READ_DATA[] = {[0:DATA_WIDTH-1]};
   }

   //To check whether the slave is giving any slave error or not
  PSLVERR_CP : coverpoint packet.pslverr{
    option.comment = "apb pslverr signal";
    bins APB_SLAVE_ERR = {0};
    bins APB_SLAVE_NO_ERR = {1};
  }

  //To check whether the apb has used strobe for all 4 lanes or not
  //PSTRB_CP : coverpoint packet.pstrb.size()*(DATA_WIDTH/8){
  //  option.comment = "apb strobe data";
  //  bins APB_PSTRB[] = {[0:(DATA_WIDTH/8)-1]};
  //}
   
  PSTRB_CP : coverpoint packet.pstrb{
    option.comment = "apb strobe data";
    bins APB_PSTRB[] = {[0:(DATA_WIDTH/8)-1]};
  }

  //CROSS OF THE CFG AND THE PACKET WITH MULTIPLE COVERPOINT
  //Cross coverage between paddr(for different slaves) and pwdata to check whether the apb avip has covered all possible cross          cases
  //Cross coverage between paddr(for different slaves) and prdata to check whether the apb avip has covered all possible cross          cases
  PADDR_CP_X_PWDATA_CP : cross PADDR_CP , PWDATA_CP;
  PADDR_CP_X_PRDATA_CP : cross PADDR_CP , PRDATA_CP;

 endgroup: apb_master_covergroup

  //Creating handle for apb_master transacion coverage
  //apb_master_tx apb_master_tx_cov_data;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_coverage", uvm_component parent = null);
  extern function void write(apb_master_tx t);
  //extern virtual function report_phase(uvm_phase phase);

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
  apb_master_covergroup = new();
  //apb_master_analysis_export = new("apb_master_analysis_export",this);
endfunction : new

//-------------------------------------------------------------------------------------------
// Function: write
// Overriding the write method declared in the parent class
//
// Parameters:
//  t - apb_master_tx
//--------------------------------------------------------------------------------------------
function void apb_master_coverage::write(apb_master_tx t);
  `uvm_info(get_type_name(),$sformatf("Before calling SAMPLE METHOD"),UVM_HIGH);

  apb_master_covergroup.sample(apb_master_agent_cfg_h,t);

  `uvm_info(get_type_name(),"After calling SAMPLE METHOD",UVM_HIGH);
  // cg.sample(master_agent_cfg_h, master_tx_cov_data);     
endfunction : write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
//function apb_master_coverage::report_phase(uvm_phase phase);
  //`uvm_info(get_type_name(), $sformatf("APB Master Agent Coverage = %0.2f %%", apb_master_covergroup.get_coverage()), UVM_NONE);
//endfunction: report_phase

`endif

