`ifndef APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_
`define APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : apb_slave_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------

class apb_slave_seq_item_converter;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input apb_slave_tx input_conv_h, output apb_transfer_char_s output_conv_h);
  extern static function void to_class(input apb_transfer_char_s input_conv_h, output apb_slave_tx output_conv_h);

endclass : apb_slave_seq_item_converter

//--------------------------------------------------------------------------------------------
// Function: from_class
//  Converting seq_item transactions into struct data items
//
// Parameters:
//  name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::from_class(input apb_slave_tx input_conv_h, 
                                                        output apb_transfer_char_s output_conv_h);
  `uvm_info("apb_slave_seq_item_conv","apb_from_class",UVM_LOW);
  
endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: to_class
//  Converting struct data items into seq_item transactions
//
// Parameters:
//  name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::to_class(input apb_transfer_char_s input_conv_h, 
                                                      output apb_slave_tx output_conv_h);
  `uvm_info("apb_slave_seq_item_conv","apb_to_class",UVM_LOW);
    
endfunction: to_class

`endif


/*class apb_slave_seq_item_converter extends uvm_object;
  `uvm_object_utils(apb_slave_seq_item_converter)


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_seq_item_converter");
  //extern static function void from_class(input apb_slave_tx input_conv_h,output spi_transfer_char_s output_conv);
  //extern static function void to_class(input spi_transfer_char_s input_conv, output slave_tx output_conv_h);
  
endclass : apb_slave_seq_item_converter


//-------------------------------------------------------
// Constructor: new
//
// parameters:
// name: apb_slave_seq_item_converter
//-------------------------------------------------------
function apb_slave_seq_item_converter::new(string name = "apb_slave_seq_item_converter");
  super.new(name);
endfunction : new

/*
//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------

function void apb_slave_seq_item_converter::from_class(input apb_slave_tx input_conv_h,
                                                        output spi_transfer_char_s output_conv);
  output_conv.no_of_miso_bits_transfer = input_conv_h.master_in_slave_out.size()*CHAR_LENGTH;
  for(int i=0; i<input_conv_h.master_out_slave_in.size(); i++) begin
    //output_conv_h.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
    output_conv.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
    //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction : from_class


//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::to_class(input spi_transfer_char_s input_conv, 
                                                      output slave_tx output_conv_h);
  for(int i=0;i<DATA_WIDTH;i++) begin
    output_conv_h = new();
    output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i];  
    output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i];  
    //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction : to_class

*/
//`endif
