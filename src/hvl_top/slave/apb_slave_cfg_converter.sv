`ifndef APB_SLAVE_CFG_CONVERTER_INCLUDED_
`define APB_SLAVE_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_cfg_converter
// Description:
// class for converting apb_slave_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class apb_slave_cfg_converter extends uvm_object;
  `uvm_object_utils(apb_slave_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_cfg_converter");

  
  extern static function void from_class(input apb_slave_agent_config input_conv_h,
                                        output apb_transfer_cfg_s  output_conv);
  //extern static function void to_class(input apb_transfer_cfg_s input_conv,output apb_master_tx
  //output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : apb_slave_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_slave_cfg_converter
//--------------------------------------------------------------------------------------------
function apb_slave_cfg_converter::new(string name = "apb_slave_cfg_converter");
  super.new(name);
endfunction : new

//-------------------------------------------------------------------------------------------
// function: from_class
// converting apb_master_cfg configurations into structure configutrations
//--------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::from_class(input apb_slave_agent_config input_conv_h,
                                                  output apb_transfer_cfg_s  output_conv);
 
endfunction:from_class

//---------------------------------------------------------------------------------------------
// function:do_print method
// print method can be added to display the data members values
//---------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::do_print(uvm_printer printer);
  
  apb_transfer_cfg_s apb_st;
  super.do_print(printer);


endfunction:do_print

`endif
