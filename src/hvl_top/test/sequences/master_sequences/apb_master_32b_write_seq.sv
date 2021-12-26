`ifndef APB_MASTER_32B_WRITE_SEQ_INCLUDE_
`define APB_MASTER_32B_WRITE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: apb_master_32b_write_seq
// Extends the apb_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class apb_master_32b_write_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_32b_write_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="apb_master_32b_write_seq");
  extern task body();
  endclass : apb_master_32b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_32b_write_seq
//--------------------------------------------------------------------------------------------
function apb_master_32b_write_seq::new(string name="apb_master_32b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_master_32b_write_seq::body();
  super.body();
  req=apb_master_tx::type_id::create("req");
  req.apb_master_agent_cfg_h = p_sequencer.apb_master_agent_cfg_h;
  start_item(req);
  if(!req.randomize() with {req.pselx == SLAVE_0;
                            //req.paddr == 'h3;
                            req.transfer_size == BIT_32;
                            req.pwrite == WRITE;}) begin
    `uvm_fatal("APB","Rand failed");
  end
  //req.print();
  finish_item(req);

endtask: body

`endif
