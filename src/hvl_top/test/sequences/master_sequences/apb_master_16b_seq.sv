`ifndef APB_MASTER_16B_SEQ_INCLUDE_
`define APB_MASTER_16B_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: apb_master_16b_seq
// <Description_here>
//--------------------------------------------------------------------------------------------

class apb_master_16b_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_16b_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="apb_master_16b_seq");
  extern task body();

endclass : apb_master_16b_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_16b_seq
//--------------------------------------------------------------------------------------------

function apb_master_16b_seq::new(string name="apb_master_16b_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
//Constructor - task
//--------------------------------------------------------------------------------------------

task apb_master_16b_seq::body();
  //super.body();
  `uvm_info(get_type_name(),$sformatf("APB_MASTER_16B_SEQ_INCLUDE_"),UVM_LOW);
  req=apb_master_tx::type_id::create("req");
  start_item(req);
  `uvm_info(get_type_name(),"req_prtint",UVM_LOW);
  if(!req.randomize() with {req.pselx == SLAVE_2;}) begin
    `uvm_fatal("APB","Rand failed")
  end
  finish_item(req);
endtask : body

`endif

