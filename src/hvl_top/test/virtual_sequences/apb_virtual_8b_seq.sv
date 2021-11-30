`ifndef APB_VIRTUAL_8B_SEQ_INCLUDED_
`define APB_VIRTUAL_8B_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_virtual_8b_seq
// <Description_here>
//--------------------------------------------------------------------------------------------

class apb_virtual_8b_seq extends apb_virtual_base_seq;
  `uvm_object_utils(apb_virtual_8b_seq)
  apb_master_8b_seq apb_master_8b_seq_h;
  apb_slave_8b_seq apb_slave_8b_seq_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------

  extern function new(string name ="apb_virtual_8b_seq");
  extern task body();

endclass : apb_virtual_8b_seq
//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_virtual_8b_seq
//--------------------------------------------------------------------------------------------

function apb_virtual_8b_seq::new(string name ="apb_virtual_8b_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Construct - body
//--------------------------------------------------------------------------------------------

task apb_virtual_8b_seq::body();
  super.body();
  apb_master_8b_seq_h=apb_master_8b_seq::type_id::create("apb_master_8b_seq_h");
  //apb_slave_8b_seq_h=apb_slave_8b_seq::type_id::create("apb_slave_8b_seq_h");
  //fork
  //forever begin
  //apb_slave_8b_seq_h.start(p_sequencer.apb_slave_seqr_h);
  //end
  //join none
   
  repeat(1) begin
    apb_master_8b_seq_h.start(p_sequencer.apb_master_seqr_h);
  end
endtask : body

`endif
