`ifndef APB_VIRTUAL_16B_WRITE_SEQ_INCLUDED_
`define APB_VIRTUAL_16B_WRITE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_virtual_16b_write_seq
//  Extended class from apb_virtul_base_seq
//--------------------------------------------------------------------------------------------

class apb_virtual_16b_write_seq extends apb_virtual_base_seq;
  `uvm_object_utils(apb_virtual_16b_write_seq)

  //Variable: apb_master_16b_write_seq_h
  //Instantiation of apb_master_16b_write_seq handle 
  apb_master_16b_write_seq  apb_master_16b_write_seq_h;
  
  //Variable: apb_slave_16b_write_seq_h
  //Instantiation of apb_slave_16b_write_seq handle 
  apb_slave_16b_write_seq   apb_slave_16b_write_seq_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------

  extern function new(string name ="apb_virtual_16b_write_seq");
  extern task body();

endclass : apb_virtual_16b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_virtual_16b_write_seq
//--------------------------------------------------------------------------------------------

function apb_virtual_16b_write_seq::new(string name ="apb_virtual_16b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task: body
//  Creates the handles and starts the sequences
//--------------------------------------------------------------------------------------------
task apb_virtual_16b_write_seq::body();
  super.body();
  apb_master_16b_write_seq_h = apb_master_16b_write_seq::type_id::create("apb_master_16b_write_seq_h");
  apb_slave_16b_write_seq_h = apb_slave_16b_write_seq::type_id::create("apb_slave_16b_write_seq_h");
  fork
    forever begin
      apb_slave_16b_write_seq_h.start(p_sequencer.apb_slave_seqr_h);
    end
  join_none
  
  repeat(2) begin
    apb_master_16b_write_seq_h.start(p_sequencer.apb_master_seqr_h);
  end

endtask : body

`endif

