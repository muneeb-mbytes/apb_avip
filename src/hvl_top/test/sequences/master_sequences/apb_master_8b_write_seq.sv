`ifndef APB_MASTER_8B_WRITE_SEQ_INCLUDE_
`define APB_MASTER_8B_WRITE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: apb_master_8b_write_seq
// Extends the apb_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class apb_master_8b_write_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_8b_write_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="apb_master_8b_write_seq");
  extern task body();
endclass : apb_master_8b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_8b_write_seq
//--------------------------------------------------------------------------------------------
function apb_master_8b_write_seq::new(string name="apb_master_8b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_master_8b_write_seq::body();
  req=apb_master_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize() with {req.pselx == SLAVE_3;
                            req.transfer_size == BIT_8;
                            req.pwrite == WRITE;}) begin
    `uvm_fatal("APB","Rand failed");
  end
  //req.print();
  finish_item(req);
endtask : body

`endif
