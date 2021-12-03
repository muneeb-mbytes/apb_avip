`ifndef APB_SLAVE_TX_INCLUDED_
`define APB_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_tx
// Contains the apb_transaction_items which will be randomised
//--------------------------------------------------------------------------------------------
class apb_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_slave_tx)
  
  //Varibale : paddr
  //Address selected in apb_slave
  bit [ADDRESS_WIDTH-1:0]paddr;

  //Variable : pprot
  //Used for different access
  bit [2:0]pprot;

  //Variable : pselx
  //Used to select the slave
  bit [NO_OF_SLAVES-1:0]pselx;

  //Variable : penable
  //Used to write data when penable is high
  bit penable;

  //Varibale : pwrite
  //Write when pwrite is 1 and read is 0
  bit pwrite;

  //Variable : pwdata
  //Used to store the wdata
  bit [DATA_WIDTH-1:0]pwdata;

  //Variable : pstrb
  //Used to transfer the data to pwdata bus
  bit [DATA_WIDTH/8-1:0]pstrb;

  //Variable : pslverr
  //Goes high when a transfer fails
  bit pslverr;

  //Variable : pready
  //Used to extend the transfer
  rand bit pready;

  //Variable : prdata
  //Used to store the rdata from the slave

  bit [DATA_WIDTH-1:0]prdata;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
endclass : apb_slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function apb_slave_tx::new(string name = "apb_slave_tx");
  super.new(name);
endfunction : new


//--------------------------------------------------------------------------------------------
//  Function: do_copy
//  Copy method is implemented using handle rhs
//
//  Parameters:
//  rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void apb_slave_tx::do_copy (uvm_object rhs);
  apb_slave_tx apb_slave_tx_copy_obj;

  if(!$cast(apb_slave_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  paddr   = apb_slave_tx_copy_obj.paddr;
  pselx    = apb_slave_tx_copy_obj.pselx;
  pwrite  = apb_slave_tx_copy_obj.pwrite;
  penable = apb_slave_tx_copy_obj.penable;
  pwdata  = apb_slave_tx_copy_obj.pwdata;
  pready  = apb_slave_tx_copy_obj.pready;
  prdata  = apb_slave_tx_copy_obj.prdata;
  pslverr = apb_slave_tx_copy_obj.pslverr;
  pprot   = apb_slave_tx_copy_obj.pprot;
  pstrb  = apb_slave_tx_copy_obj.pstrb;

endfunction:do_copy

//--------------------------------------------------------------------------------------------
//  Function: do_compare
//  Compare method is implemented using handle rhs
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit apb_slave_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  apb_slave_tx apb_slave_tx_compare_obj;

  if(!$cast(apb_slave_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_APB_SLAVE_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(apb_slave_tx_compare_obj, comparer) &&
  paddr   == apb_slave_tx_compare_obj.paddr &&
  pselx    == apb_slave_tx_compare_obj.pselx &&
  pwrite  == apb_slave_tx_compare_obj.pwrite &&
  penable == apb_slave_tx_compare_obj.penable &&
  pwdata  == apb_slave_tx_compare_obj.pwdata &&
  pready  == apb_slave_tx_compare_obj.pready &&
  prdata  == apb_slave_tx_compare_obj.prdata &&
  pslverr == apb_slave_tx_compare_obj.pslverr &&
  pprot   == apb_slave_tx_compare_obj.pprot &&
  pstrb  == apb_slave_tx_compare_obj.pstrb;
endfunction:do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
//  Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void apb_slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("paddr",paddr,$bits(paddr),UVM_DEC);
  printer.print_field("pselx",pselx,1,UVM_DEC);
  printer.print_field("penable",penable,1,UVM_DEC);
  printer.print_field("pwrite",pwrite,1,UVM_DEC);
  printer.print_field("pwdata",pwdata,$bits(pwdata),UVM_DEC);
  printer.print_field("pready",pready,1,UVM_DEC);
  printer.print_field("prdata",prdata,$bits(prdata),UVM_DEC);
  printer.print_field("pprot",pprot,$bits(pprot),UVM_DEC);
  printer.print_field("pstrb",pstrb,$bits(pstrb),UVM_DEC);
  printer.print_field("pslverr",pslverr,$bits(pslverr),UVM_DEC);

endfunction : do_print


`endif

