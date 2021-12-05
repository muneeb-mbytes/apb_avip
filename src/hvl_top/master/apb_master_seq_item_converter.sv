`ifndef APB_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_
`define APB_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : apb_master_seq_item_converter
// This class converts seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class apb_master_seq_item_converter extends uvm_object;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_seq_item_converter");
  extern static function void from_class(input apb_master_tx input_conv, output apb_transfer_char_s output_conv);
  extern static function void to_class(input apb_transfer_char_s input_conv, output apb_master_tx
  output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : apb_master_seq_item_converter

//-------------------------------------------------------
// construct:new
// Parameters:
// name - apb_master_seq_item_converter
//-------------------------------------------------------
function apb_master_seq_item_converter::new(string name = "apb_master_seq_item_converter");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// Function: from_class
// Converting seq_item transactions into struct data items
//
// Parameters:
// name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::from_class(input apb_master_tx input_conv, 
                                                        output apb_transfer_char_s output_conv);
  //tx_type_e tx_type;
  //bit write
  $cast(output_conv.pwrite,input_conv.tx_type);
  output_conv.pprot = input_conv.pprot;
  output_conv.pselx = input_conv.pselx;
  //output_conv.pwrite = input_conv.tx_type.value();
  output_conv.paddr = input_conv.paddr;
  output_conv.pwdata = input_conv.pwdata;
  output_conv.pstrb = input_conv.pstrb;
  output_conv.pslverr = input_conv.pslverr;
  //output_conv.pready = input_conv.pready;
  output_conv.prdata = input_conv.prdata;

  //`uvm_info("apb_master_seq_item_conv","apb_from_class",UVM_LOW);
  
endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: to_class
// Converting struct data items into seq_item transactions
//
// Parameters:
// name - apb_master_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::to_class(input apb_transfer_char_s input_conv, 
                                                      output apb_master_tx output_conv_h);
  output_conv_h = new();

  output_conv_h.pprot = input_conv.pprot;
  output_conv_h.pselx = input_conv.pselx;
  //output_conv_h.tx_type.value = input_conv.pwrite;
  output_conv_h.paddr = input_conv.paddr;
  output_conv_h.pwdata = input_conv.pwdata;
  output_conv_h.pstrb = input_conv.pstrb;
  output_conv_h.pslverr = input_conv.pslverr;
  //output_conv_h.pready = input_conv.pready;
  output_conv_h.prdata = input_conv.prdata;
  
  //`uvm_info("apb_master_seq_item_conv","apb_to_class",UVM_LOW);
    
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function : do_print method
// Print method can be added to display the data members values
//---------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::do_print(uvm_printer printer);
  apb_transfer_char_s apb_st;
  super.do_print(printer);

    printer.print_field($sformatf("pwdata"),apb_st.pwdata,DATA_WIDTH,UVM_DEC);
    printer.print_field($sformatf("prdata"),apb_st.prdata,DATA_WIDTH,UVM_DEC);
    printer.print_field("pprot",apb_st.pprot,2,UVM_BIN);
    printer.print_field("pselx",apb_st.pselx,NO_OF_SLAVES,UVM_BIN);
    //printer.print_field("pwrite",apb_st.tx_type,1,UVM_BIN);
    printer.print_field("pstrb",apb_st.pstrb,DATA_WIDTH/8,UVM_BIN);
    printer.print_field("pslverr",apb_st.pslverr,1,UVM_BIN);
    //printer.print_field("pready",apb_st.pready,1,UVM_BIN);

endfunction: do_print  

`endif
  
