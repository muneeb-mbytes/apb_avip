`ifndef APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_
`define APB_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : apb_slave_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------

class apb_slave_seq_item_converter extends uvm_object;
  
//------------------------------------------------------------------------------------------
// Externally defined Tasks and Functions
//------------------------------------------------------------------------------------------
  extern function new(string name = "apb_slave_seq_item_converter");
  extern static function void from_class(input apb_slave_tx input_conv_h, output apb_transfer_char_s output_conv);
  extern static function void to_class(input apb_transfer_char_s input_conv, output apb_slave_tx output_conv_h);
  extern function void do_print(uvm_printer printer);


endclass : apb_slave_seq_item_converter

//-------------------------------------------------------
// Construct: new
//
// Parameters:
// name - apb_slave_seq_item_converter
//-------------------------------------------------------
function apb_slave_seq_item_converter::new(string name ="apb_slave_seq_item_converter");
  super.new(name);
endfunction:new

//--------------------------------------------------------------------------------------------
// Function: from_class
// Converting seq_item transactions into struct data items
//
// Parameters:
// name - apb_slave_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::from_class(input apb_slave_tx input_conv_h, 
                                                       output apb_transfer_char_s output_conv);
  output_conv.pprot = input_conv_h.pprot;
  output_conv.psel = input_conv_h.psel;
  output_conv.pwrite = input_conv_h.pwrite;
  output_conv.pwdata = input_conv_h.pwdata;
  output_conv.pstrobe = input_conv_h.pstrobe;
  output_conv.pslverr = input_conv_h.pslverr;
  output_conv.pready = input_conv_h.pready;
  output_conv.prdata = input_conv_h.prdata;
  `uvm_info("apb_slave_seq_item_conv","apb_from_class",UVM_LOW);
  
endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: to_class
// Converting struct data items into seq_item transactions
//
// Parameters:
// name - apb_slave_tx, apb_transfer_char_s
//--------------------------------------------------------------------------------------------
function void apb_slave_seq_item_converter::to_class(input apb_transfer_char_s input_conv, 
                                                      output apb_slave_tx output_conv_h);
  output_conv_h = new();

  output_conv_h.pprot = input_conv.pprot;
  output_conv_h.psel = input_conv.psel;
  output_conv_h.pwrite = input_conv.pwrite;
  output_conv_h.pwdata = input_conv.pwdata;
  output_conv_h.pstrobe = input_conv.pstrobe;
  output_conv_h.pslverr = input_conv.pslverr;
  output_conv_h.pready = input_conv.pready;
  output_conv_h.prdata = input_conv.prdata;
`uvm_info("apb_slave_seq_item_conv","apb_to_class",UVM_LOW);
    
endfunction: to_class

//-------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//-------------------------------------------------------
function void apb_slave_seq_item_converter::do_print(uvm_printer printer);
  apb_transfer_char_s apb_st;
  super.do_print(printer);
  
   foreach(apb_st.pwdata[i])begin
    printer.print_field($sformatf("pwdata[%0d]",i),pwdata[i],8,UVM_HEX);
  end

   foreach(apb_st.prdata[i])begin
    printer.print_field($sformatf("prdata[%0d]",i),prdata[i],8,UVM_HEX);
  end

  foreach(apb_st.pprot[i])begin
    printer.print_field("pprot",apb_st.pprot,2,UVM_BIN);
  end 

    foreach(apb_st.psel[i])begin
    printer.print_field("psel",apb_st.psel,2,UVM_BIN);
  end 
  
  foreach(apb_st.pwrite[i])begin
    printer.print_field("pwrite",apb_st.pwrite,2,UVM_BIN);
  end  

  foreach(apb_st.pstrobe[i])begin
    printer.print_field("pstrobe",apb_st.pstrobe,2,UVM_BIN);
  end  
  foreach(apb_st.pslverr[i])begin
    printer.print_field("pslverr",apb_st.pslverr,2,UVM_BIN);
  end  
  foreach(apb_st.pready[i])begin
    printer.print_field("pready",apb_st.pready,2,UVM_BIN);
  end  


endfunction: do_print
`endif

