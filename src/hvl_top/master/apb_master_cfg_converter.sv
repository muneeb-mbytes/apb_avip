`ifndef APB_MASTER_CFG_CONVERTER_INCLUDED_
`define APB_MASTER_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_cfg_converter
// Description:
// class for converting master_cfg configuration into struct configurations
//--------------------------------------------------------------------------------------------
class apb_master_cfg_converter extends uvm_object;
  `uvm_object_utils(apb_master_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_cfg_converter");

  extern static function void from_class(input apb_master_agent_config input_conv_h, output apb_transfer_cfg_s output_conv);
  //extern static function void to_class(input apb_transfer_cfg_s input_conv,output apb_master_tx
  //output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : apb_master_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - apb_master_cfg_converter
//--------------------------------------------------------------------------------------------
function apb_master_cfg_converter::new(string name = "apb_master_cfg_converter");
  super.new(name);
endfunction : new

//-------------------------------------------------------------------------------------------
// function: from_class
// converting apb_master_cfg configurations into structure configutrations
//--------------------------------------------------------------------------------------------
function void apb_master_cfg_converter::from_class(input apb_master_agent_config input_conv_h, output apb_transfer_cfg_s output_conv);
  output_conv.paddr = input_conv_h.paddr; 
  `uvm_info("apb_master_cfg_converter",$sformatf("after randomizing addr = \n %p",output_conv.paddr),UVM_HIGH);
endfunction:from_class

//---------------------------------------------------------------------------------------------
// function:do_print method
// print method can be added to display the data members values
//---------------------------------------------------------------------------------------------
function void apb_master_cfg_converter::do_print(uvm_printer printer);
  
  apb_transfer_cfg_s apb_st;
  super.do_print(printer);
  printer.print_field( "paddr", apb_st.paddr , $bits(apb_st.paddr),UVM_DEC);

endfunction:do_print

`endif

