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
  
  extern static function void from_class(input apb_slave_agent_config input_conv_h, output apb_transfer_cfg_s output_conv_h);
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
// converting apb_slave_cfg configurations into structure configutrations
//--------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::from_class(input apb_slave_agent_config input_conv_h, output apb_transfer_cfg_s output_conv_h);
  
  `uvm_info("apb_slave_config_converter","-------------------SLAVE_CFG_CONVERTER----------------------------- ",UVM_HIGH);
  `uvm_info("apb_slave_config_converter",$sformatf("Before randomizing the min_address = \n %0h",output_conv_h.min_address),UVM_HIGH);
  output_conv_h.min_address = input_conv_h.min_address; 
  `uvm_info("apb_slave_config_converter",$sformatf("After randomizing the min_address = \n %0h",output_conv_h.min_address),UVM_HIGH);

  `uvm_info("apb_slave_config_converter",$sformatf("Before randomizing the max_address = \n %0h",output_conv_h.max_address),UVM_HIGH);
  output_conv_h.max_address = input_conv_h.max_address; 
  `uvm_info("apb_slave_config_converter",$sformatf("After randomizing the max_address = \n %0h",output_conv_h.max_address),UVM_HIGH);
  `uvm_info("apb_slave_config_converter","------------------------------------------------------------------- ",UVM_HIGH);
endfunction:from_class

//---------------------------------------------------------------------------------------------
// Function:do_print method
// Print method can be added to display the data members values
// Parameters :
//    printer   - uvm_printer
//---------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::do_print(uvm_printer printer);
  
  apb_transfer_cfg_s apb_st;
  super.do_print(printer);
  printer.print_field( "min_address", apb_st.min_address , $bits(apb_st.min_address),UVM_HEX);
  printer.print_field( "max_address", apb_st.max_address , $bits(apb_st.max_address),UVM_HEX);

endfunction:do_print

`endif

