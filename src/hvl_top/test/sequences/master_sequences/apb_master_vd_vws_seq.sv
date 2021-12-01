`ifndef APB_MASTER_VD_VWS_SEQ_INCLUDED_
`define APB_MASTER_VD_VWS_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_vd_vws_seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class apb_master_vd_vws_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_vd_vws_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_vd_vws_seq");
  extern task body();
endclass : apb_master_vd_vws_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_vd_vws_seq
//--------------------------------------------------------------------------------------------
function apb_master_vd_vws_seq::new(string name = "apb_master_vd_vws_seq");
  super.new(name);
endfunction : new
//--------------------------------------------------------------------------------------------
//
//
//--------------------------------------------------------------------------------------------
task apb_master_vd_vws_seq::body();
  //`uvm_info(get_type_name(),$sformatf("APB_MASTER_VD_VWS_SEQ"),UVM_LOW);
  req = apb_master_tx::type_id::create("req");
  start_item(req);
  //`uvm_info(get_type_name(),"REQ_MASTER",UVM_LOW);
    if(!req.randomize()) 
      /*with {req.paddr inside {[0:8]};
                              req.pwdata inside {[0:8]};
                              $countones(req.psel) == NO_OF_SLAVES-1;
                             })*/ 
    begin
      `uvm_error(get_type_name(),"Randomisation failed");
    end
    req.print();
  finish_item(req);
endtask : body

`endif

