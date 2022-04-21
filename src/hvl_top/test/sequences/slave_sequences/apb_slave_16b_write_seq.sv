`ifndef APB_SLAVE_16B_WRITE_SEQ_INCLUDED_
`define APB_SLAVE_16B_WRITE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_16b_write_seq
//  This class extends from apb_slave_base_seq
//--------------------------------------------------------------------------------------------
class apb_slave_16b_write_seq extends apb_slave_base_seq;
  `uvm_object_utils(apb_slave_16b_write_seq)
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name="apb_slave_16b_write_seq");
  extern task body();

endclass : apb_slave_16b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializing new memory
//
// Parameters:
//  name - apb_slave_16b_write_seq
//--------------------------------------------------------------------------------------------
function apb_slave_16b_write_seq::new(string name="apb_slave_16b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task: body
//  This task drives the information based on the request
//--------------------------------------------------------------------------------------------
task apb_slave_16b_write_seq::body();
  `uvm_info(get_type_name(),$sformatf("APB_SLAVE_16b_write_SEQ"),UVM_LOW);
  req=apb_slave_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize())
  begin
    `uvm_error(get_type_name(),"randomization failed");
  end
  req.print();
  finish_item(req);
endtask : body

`endif

