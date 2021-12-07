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
  
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("----------------------------------------------------------------------"),UVM_LOW);
  output_conv.pprot = input_conv.pprot;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pprot = \n %b",output_conv.pprot),UVM_LOW);

  $cast(output_conv.pselx,input_conv.pselx);
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pselx = \n %b",output_conv.pselx),UVM_LOW);

  $cast(output_conv.pwrite,input_conv.tx_type);
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomizing pwrite = \n %p",output_conv.pwrite),UVM_LOW);

  output_conv.paddr = input_conv.paddr;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("after writnig addr = \n %p",output_conv.paddr),UVM_LOW);

  output_conv.pwdata = input_conv.pwdata;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("after randomizing pwdata = \n %p",output_conv.pwdata),UVM_LOW);

  output_conv.pstrb = input_conv.pstrb;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pstrb = \n %p",output_conv.pstrb),UVM_LOW);

  //output_conv.pslverr = input_conv.pslverr;
  $cast(output_conv.pslverr,input_conv.pslverr);
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pslverr = \n %p",output_conv.pslverr),UVM_LOW);

  output_conv.prdata = input_conv.prdata;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("Before randomize prdata = \n %p",output_conv.prdata),UVM_LOW);

  `uvm_info("apb_master_seq_item_conv_class",$sformatf("----------------------------------------------------------------------"),UVM_LOW);
 
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
   `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pprot = \n %p",output_conv_h.pprot),UVM_LOW);
 
   $cast(output_conv_h.pselx,input_conv.pselx);
   `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pselx = \n %p",output_conv_h.pselx),UVM_LOW);

  $cast(output_conv_h.tx_type,input_conv.pwrite);
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize paddr = \n %p",output_conv_h.paddr),UVM_LOW);
  
  output_conv_h.paddr = input_conv.paddr;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize paddr = \n %p",output_conv_h.paddr),UVM_LOW);

  output_conv_h.pwdata = input_conv.pwdata;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pwdata = \n %p",output_conv_h.pwdata),UVM_LOW);

  output_conv_h.pstrb = input_conv.pstrb;
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pwdta = \n %p",output_conv_h.pstrb),UVM_LOW);
 
  //output_conv_h.pslverr = input_conv.pslverr;
  $cast(output_conv_h.pslverr,input_conv.pslverr);
  `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize pslverr = \n %p",output_conv_h.pslverr),UVM_LOW);  

  output_conv_h.prdata = input_conv.prdata;
   `uvm_info("apb_master_seq_item_conv_class",$sformatf("After randomize prdata = \n %p",output_conv_h.prdata),UVM_LOW);

  `uvm_info("apb_master_seq_item_conv",$sformatf("------------------------------------------------"),UVM_LOW);
    
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function : do_print method
// Print method can be added to display the data members values
//---------------------------------------------------------------------------------------------
function void apb_master_seq_item_converter::do_print(uvm_printer printer);
  apb_transfer_char_s apb_st;
  super.do_print(printer);

    printer.print_field("pwdata",apb_st.pwdata,$bits(apb_st.pwdata),UVM_DEC);
    printer.print_field("prdata",apb_st.prdata,$bits(apb_st.prdata),UVM_DEC);
    printer.print_field("pprot",apb_st.pprot,$bits(apb_st.pprot),UVM_BIN);
    printer.print_field("pselx",apb_st.pselx,$bits(apb_st.pselx),UVM_BIN);
    printer.print_field("pwrite",apb_st.pwrite,$bits(apb_st.pwrite),UVM_BIN);
    printer.print_field("pstrb",apb_st.pstrb,$bits(apb_st.pstrb),UVM_BIN);
    printer.print_field("pslverr",apb_st.pslverr,$bits(apb_st.pslverr),UVM_BIN);
    //printer.print_field("pready",apb_st.pready,1,UVM_BIN);

endfunction: do_print  

`endif
  
