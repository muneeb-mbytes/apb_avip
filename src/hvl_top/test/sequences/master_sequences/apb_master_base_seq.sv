`ifndef APB_MASTER_BASE_SEQ_INCLUDED_
`define APB_MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class : master_base_seq
// Creating master_base_seq extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class apb_master_base_seq extends uvm_sequence#(apb_master_tx);
  `uvm_object_utils(apb_master_base_seq)

  `uvm_declare_p_sequencer(apb_master_sequencer) 

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_master_base_seq");
  extern task body();
endclass : apb_master_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_base_seq
//--------------------------------------------------------------------------------------------
function apb_master_base_seq::new(string name = "apb_master_base_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task apb_master_base_seq::body();

  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
            
endtask:body
`endif
