`ifndef APB_SLAVE_CFG_CONVERTER_INCLUDED_
`define APB_SLAVE_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_cfg_converter
//  Class for converting apb_slave_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class apb_slave_cfg_converter extends uvm_object;
  `uvm_object_utils(apb_slave_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_cfg_converter");
  extern static function void from_class(input apb_slave_agent_config input_conv_h, output apb_transfer_cfg_s output_conv_h);
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
// Function: from_class
//  Converting apb_slave_cfg configurations into structure configutrations
//--------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::from_class(input apb_slave_agent_config input_conv_h, 
                                                  output apb_transfer_cfg_s output_conv_h);
  
  `uvm_info("apb_seq_item_conv_from_class",$sformatf("--\n----------------------------------------SLAVE_CFG_CONVERTER_FROM_CLASS--------------------------------------"),UVM_HIGH);
  `uvm_info("apb_slave_config_converter",$sformatf("Before randomizing min_address = %0h",output_conv_h.min_address),UVM_HIGH);
  output_conv_h.min_address = input_conv_h.min_address; 
  `uvm_info("apb_slave_config_converter",$sformatf("After randomizing the min_address = %0h",output_conv_h.min_address),UVM_HIGH);

  `uvm_info("apb_slave_config_converter",$sformatf("Before randomizing max_address = %0h",output_conv_h.max_address),UVM_HIGH);
  output_conv_h.max_address = input_conv_h.max_address; 
  `uvm_info("apb_slave_config_converter",$sformatf("After randomizing the max_address = %0h",output_conv_h.max_address),UVM_HIGH);
  output_conv_h.slave_id = input_conv_h.slave_id;
  `uvm_info("apb_slave_config_converter",$sformatf("After randomizing the slave_id = %0h",output_conv_h.slave_id),UVM_HIGH);

  `uvm_info("apb_slave_config_converter","--\n------------------------------------------------------------EOP---------------------------------------------------- ",UVM_HIGH);

endfunction : from_class

//---------------------------------------------------------------------------------------------
// Function: do_print method
//  Print method can be added to display the data members values
// 
// Parameters:
//  printer   - uvm_printer
//---------------------------------------------------------------------------------------------
function void apb_slave_cfg_converter::do_print(uvm_printer printer);
  
  apb_transfer_cfg_s apb_st;
  super.do_print(printer);
  printer.print_field( "min_address", apb_st.min_address, $bits(apb_st.min_address),UVM_HEX);
  printer.print_field( "max_address", apb_st.max_address, $bits(apb_st.max_address),UVM_HEX);

endfunction : do_print

`endif

