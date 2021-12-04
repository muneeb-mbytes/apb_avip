`ifndef APB_MASTER_VD_VWS_SEQ_INCLUDED_
`define APB_MASTER_VD_VWS_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_master_vd_vws_seq
// Extends the apb_master_base_seq and randomises the req item
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
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_master_vd_vws_seq::body();
  req = apb_master_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize()) /*with {req.paddr inside {[0:8]};
                              req.pwdata inside {[0:8]};
                              $countones(req.psel) == NO_OF_SLAVES-1;
                             })*/ 
  begin
    `uvm_fatal(get_type_name(),"Randomisation failed");
  end
  req.print();
  finish_item(req);
endtask : body

`endif

