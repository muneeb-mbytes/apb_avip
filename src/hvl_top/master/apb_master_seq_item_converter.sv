`ifndef APB_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_
`define APB_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : apb_master_seq_item_converter
// This class converts seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class apb_master_seq_item_converter;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input apb_master_tx input_conv_h, output apb_transfer_char_s output_conv_h);
  extern static function void to_class(input apb_transfer_char_s input_conv_h, output apb_master_tx output_conv_h);

endclass : apb_master_seq_item_converter

//--------------------------------------------------------------------------------------------
// Function: from_class
//  Converting seq_item transactions into struct data items
//
// Parameters:
//  name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::from_class(input apb_master_tx input_conv_h, output apb_transfer_char_s output_conv_h);
  `uvm_info("apb_master_seq_item_conv","apb_from_class",UVM_LOW);
  
endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: to_class
//  Converting struct data items into seq_item transactions
//
// Parameters:
//  name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::to_class(input apb_transfer_char_s input_conv_h, output apb_master_tx output_conv_h);
  `uvm_info("apb_master_seq_item_conv","apb_to_class",UVM_LOW);
    
endfunction: to_class

`endif

