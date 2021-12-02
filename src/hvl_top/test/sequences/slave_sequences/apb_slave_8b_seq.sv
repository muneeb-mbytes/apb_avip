`ifndef APB_SLAVE_8B_INCLUDED_
`define APB_SLAVE_8B_INCLUDED_

class apb_slave_8b_seq extends apb_slave_base_seq;
  `uvm_object_utils(apb_slave_8b_seq)
  extern function new(string name="apb_slave_8b_seq");
  extern task body();
endclass : apb_slave_8b_seq

function apb_slave_8b_seq::new(string name="apb_slave_8b_seq");
  super.new(name);
endfunction : new

task apb_slave_8b_seq::body();
  `uvm_info(get_type_name(),$sformatf("APB_SLAVE_8B_SEQ"),UVM_LOW);
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
