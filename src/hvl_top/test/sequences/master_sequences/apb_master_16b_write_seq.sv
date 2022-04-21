`ifndef APB_MASTER_16B_WRITE_SEQ_INCLUDE_
`define APB_MASTER_16B_WRITE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: apb_master_16b_write_seq
//  This class extends from apb_master_base_seq
//--------------------------------------------------------------------------------------------
class apb_master_16b_write_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_16b_write_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="apb_master_16b_write_seq");
  extern task body();

endclass : apb_master_16b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializing new memory
//
// Parameters:
//  name - apb_master_16b_write_seq
//--------------------------------------------------------------------------------------------
function apb_master_16b_write_seq::new(string name="apb_master_16b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task: body
//  This task drives the information based on the request
//--------------------------------------------------------------------------------------------
task apb_master_16b_write_seq::body();
  super.body();
  `uvm_info(get_type_name(),$sformatf("apb_master_16b_write_seq"),UVM_LOW);
  req=apb_master_tx::type_id::create("req");
  req.apb_master_agent_cfg_h = p_sequencer.apb_master_agent_cfg_h;
  start_item(req);
  `uvm_info(get_type_name(),"req_print",UVM_LOW);
  if(!req.randomize() with {req.pselx == SLAVE_0; 
                            req.pwrite == WRITE;
                            req.transfer_size == BIT_16;}) begin
    `uvm_fatal("APB","Rand failed")
  end
  finish_item(req);
endtask : body

`endif

