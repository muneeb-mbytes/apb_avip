`ifndef APB_MASTER_TX_INCLUDED_
`define APB_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_tx.
// Description of the class.
// This class holds the data items required to drive stimulus to dut
// and also holds methods that manipulatethose data items
//--------------------------------------------------------------------------------------------
class apb_master_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_master_tx)

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
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_copy (uvm_object rhs);
  apb_master_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  
  super.do_copy(rhs);
//  cs= rhs_.cs;
//  foreach(apb_master_out_slave_in[i])
//  apb_master_out_slave_in[i]= rhs_.apb_master_out_slave_in[i];
//  foreach(apb_master_in_slave_out[i])
//  apb_master_in_slave_out[i]= rhs_.apb_master_in_slave_out[i];

endfunction:do_copy

//--------------------------------------------------------------------------------------------
//  Function: do_compare
//  Compare method is implemented using handle rhs
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit apb_master_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  apb_master_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("FATAL_APB_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

//  return super.do_compare(rhs,comparer) &&
//  apb_master_out_slave_in== rhs_.apb_master_out_slave_in &&
//  apb_master_in_slave_out== rhs_.apb_master_in_slave_out;
endfunction:do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
//  printer.print_field( "cs", cs , 2,UVM_DEC);
//  foreach(apb_master_out_slave_in[i])
//    printer.print_field($sformatf("apb_master_out_slave_in[%0d]",i),this.apb_master_out_slave_in[i],8,UVM_HEX);
//  foreach(apb_master_in_slave_out[i])
//    printer.print_field($sformatf("apb_master_in_slave_out[%0d]",i),this.apb_master_in_slave_out[i],8,UVM_HEX);

endfunction : do_print

`endif

