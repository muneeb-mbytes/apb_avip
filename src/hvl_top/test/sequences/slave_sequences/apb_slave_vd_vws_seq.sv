`ifndef APB_SLAVE_VD_VWS_INCLUDED_
`define APB_SLAVE_VD_VWS_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_vd_vws
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_slave_vd_vws_seq extends apb_slave_base_seq;
  `uvm_object_utils(apb_slave_vd_vws_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_vd_vws_seq");
  extern task body();
endclass : apb_slave_vd_vws_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_slave_vd_vws
//--------------------------------------------------------------------------------------------
function apb_slave_vd_vws_seq::new(string name = "apb_slave_vd_vws_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : Body
//--------------------------------------------------------------------------------------------
task apb_slave_vd_vws_seq::body();
  `uvm_info(get_type_name(),$sformatf("APB_SLAVE_VD_VWS_SEQ"),UVM_LOW);
  req = apb_slave_tx::type_id::create("req");
  //start_item(req);
  `uvm_info(get_type_name(),"REQ_SLAVE",UVM_LOW);
    if(!req.randomize()) begin
      `uvm_fatal(get_type_name(),"Randomisation failed");
    end
    req.print();
  //finish_item(req);
endtask : body
`endif

