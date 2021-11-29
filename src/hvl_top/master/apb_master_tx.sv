`ifndef APB_MASTER_TX_INCLUDED_
`define APB_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_tx.
// This class holds the data items required to drive stimulus to dut 
// and also holds methods that manipulate those data items
//--------------------------------------------------------------------------------------------
class apb_master_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_master_tx)

  //Varibale : paddr
  //Address selected in apb_slave
  rand bit [ADDRESS_LENGTH-1:0]paddr;

  //Variable : pprot
  //Used for different access
  rand bit [2:0]pprot;

  //Variable : psel
  //Used to select the slave
  rand bit [NO_OF_SLAVES-1:0]psel;

  //Variable : penable
  //Used to write data when penable is high
  rand bit penable;

  //Varibale : pwrite
  //Write when pwrite is 1 and read is 0
  rand bit pwrite;

  //Variable : pwdata
  //Used to store the wdata
  rand bit [DATA_WIDTH-1:0]pwdata;

  //Variable : pstrob
  //Used to transfer the data to pwdata bus
  rand bit [DATA_WIDTH-1:0]pstrob;

  //Variable : pslverr
  //Goes high when a transfer fails
  bit pslverr;

  //Variable : pready
  //Used to extend the transfer
  bit pready;

  //Variable : prdata
  //Used to store the rdata from the slave
  bit prdata;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : apb_master_tx

//--------------------------------------------------------------------------------------------
//  Construct: new
//  initializes the class object
//
//  Parameters:
//  name - apb_master_tx
//--------------------------------------------------------------------------------------------
function apb_master_tx::new(string name = "apb_master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: do_copy
//  Copy method is implemented using handle rhs
//
//  Parameters:
//  rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_copy (uvm_object rhs);
  apb_master_tx apb_master_tx_copy_obj;

  if(!$cast(apb_master_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  paddr   = apb_master_tx_copy_obj.paddr;
  psel    = apb_master_tx_copy_obj.psel;
  pwrite  = apb_master_tx_copy_obj.pwrite;
  penable = apb_master_tx_copy_obj.penable;
  pwdata  = apb_master_tx_copy_obj.pwdata;
  pready  = apb_master_tx_copy_obj.pready;
  prdata  = apb_master_tx_copy_obj.prdata;
  pslverr = apb_master_tx_copy_obj.pslverr;
  pprot   = apb_master_tx_copy_obj.pprot;
  pstrob  = apb_master_tx_copy_obj.pstrob;
endfunction:do_copy

//--------------------------------------------------------------------------------------------
//  Function: do_compare
//  Compare method is implemented using handle rhs
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit apb_master_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  apb_master_tx apb_master_tx_compare_obj;

  if(!$cast(apb_master_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_APB_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(apb_master_tx_compare_obj, comparer) &&
  paddr   == apb_master_tx_compare_obj.paddr &&
  psel    == apb_master_tx_compare_obj.psel &&
  pwrite  == apb_master_tx_compare_obj.pwrite &&
  penable == apb_master_tx_compare_obj.penable &&
  pwdata  == apb_master_tx_compare_obj.pwdata &&
  pready  == apb_master_tx_compare_obj.pready &&
  prdata  == apb_master_tx_compare_obj.prdata &&
  pslverr == apb_master_tx_compare_obj.pslverr &&
  pprot   == apb_master_tx_compare_obj.pprot &&
  pstrob  == apb_master_tx_compare_obj.pstrob;
endfunction:do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
//  Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field ("paddr",    paddr,    $bits(paddr),   UVM_DEC);
  printer.print_field ("psel",     psel,     $bits(psel),    UVM_DEC);
  printer.print_field ("penable",  penable,  $bits(penable), UVM_DEC);
  printer.print_field ("pwrite",   pwrite,   $bits(pwrite),  UVM_DEC);
  printer.print_field ("pwdata",   pwdata,   $bits(pwdata),  UVM_DEC);
  printer.print_field ("pready",   pready,   $bits(pready),  UVM_DEC);
  printer.print_field ("prdata",   prdata,   $bits(prdata),  UVM_DEC);
  printer.print_field ("pprot",    pprot,    $bits(pprot),   UVM_DEC);
  printer.print_field ("pstrob",   pstrob,   $bits(pstrob),  UVM_DEC);
  printer.print_field ("pslverr",  pslverr,  $bits(pslverr), UVM_DEC);

endfunction : do_print

`endif

