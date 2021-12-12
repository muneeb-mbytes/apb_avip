`ifndef APB_SCOREBOARD_INCLUDED_
`define APB_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_scoreboard
// Used to compare the data from the master monitor proxy and slave monitor proxy
//--------------------------------------------------------------------------------------------
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  //Variable : apb_master_tx_h
  //Declaring handle for apb_master_tx
  apb_master_tx apb_master_tx_h;

  //Variable : apb_slave_tx_h
  //Declaring handle for apb_slaver_tx
  apb_slave_tx apb_slave_tx_h;
  
  //Variable : apb_master_analysis_fifo
  //Used to store the apb_master_data
  uvm_tlm_analysis_fifo#(apb_master_tx) apb_master_analysis_fifo;

  //Variable : apb_slave_analysis_fifo
  //Used to store the apb_slave_data
  uvm_tlm_analysis_fifo#(apb_slave_tx) apb_slave_analysis_fifo;
  //uvm_tlm_analysis_fifo#(apb_slave_tx) apb_slave_analysis_fifo[NO_OF_SLAVES];

  //Variable : apb_master_tx_count
  //to keep track of number of transactions for master 
  int apb_master_tx_count = 0;


  //Variable : apb_slave_tx_count
  //to keep track of number of transactions for slave 
  int apb_slave_tx_count = 0;


  //Variable byte_data_cmp_verified_master_tx_count
  //to keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_tx_count = 0;


  //Variable byte_data_cmp_verified_slave_tx_count
  //to keep track of number of byte wise compared verified slave_tx_data
  int byte_data_cmp_verified_slave_tx_count = 0;


  //Variable byte_data_cmp_failed_master_tx_count
  //to keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_tx_count = 0;


  //Variable byte_data_cmp_failed_slave_tx_count
  //to keep track of number of byte wise compared failed slave_tx_data
  int byte_data_cmp_failed_slave_tx_count = 0;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

endclass : apb_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
// Initialization of new memory
//
// Parameters:
//  name - apb_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_scoreboard::new(string name = "apb_scoreboard",uvm_component parent = null);
  super.new(name, parent);
  apb_master_analysis_fifo = new("apb_master_analysis_fifo",this);
  apb_slave_analysis_fifo  = new("apb_slave_analysis_fifo",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds its parent components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task apb_scoreboard::run_phase(uvm_phase phase);

  super.run_phase(phase);

  forever begin
 
  `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
   apb_master_analysis_fifo.get(apb_master_tx_h);
   // TODO(mshariff): Keep a track on master transaction
   apb_master_tx_count++;
  
   `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
   `uvm_info(get_type_name(),$sformatf("printing apb_master_tx_h, \n %s",apb_master_tx_h.sprint()),UVM_HIGH)
  
   //TODO apb_slave_tx_h.slave_id = 2**NO_OF_SLAVE;
   
   apb_slave_analysis_fifo .get(apb_slave_tx_h);
   // TODO(mshariff): Keep a track on slave transaction
   apb_slave_tx_count++;
   
   `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
   `uvm_info(get_type_name(),$sformatf("printing apb_slave_tx_h, \n %s",apb_slave_tx_h.sprint()),UVM_HIGH)

   //Data comparision for master
   
   //verifying pwdata in master and slave 
   if(apb_master_tx_h.pwdata == apb_slave_tx_h.pwdata) begin
     `uvm_info(get_type_name(),$sformatf("apb_pwdata from master and slave is equal"),UVM_HIGH);
   end

   else begin
     `uvm_info(get_type_name(),$sformatf("apb_pwdata from master and slave is not equal"),UVM_HIGH);
   end
  
   //verifying paddr in master and slave 
   if(apb_master_tx_h.paddr == apb_slave_tx_h.paddr) begin
     `uvm_info(get_type_name(),$sformatf("apb_paddr from master and slave is equal"),UVM_HIGH);
   end

   else begin
     `uvm_info(get_type_name(),$sformatf("apb_paddr from master and slave is not equal"),UVM_HIGH);
   end

   //verifying pwrite in master and slave 
   if(apb_master_tx_h.pwrite == apb_slave_tx_h.pwrite) begin
     `uvm_info(get_type_name(),$sformatf("apb_pwrite from master and slave is equal"),UVM_HIGH);
   end

   else begin
     `uvm_info(get_type_name(),$sformatf("apb_pwrite from master and slave is not equal"),UVM_HIGH);
   end


   //Data comparision for slave
  
   //verifying prdata in master and slave 
   if(apb_slave_tx_h.prdata == apb_master_tx_h.prdata) begin
     `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is equal"),UVM_HIGH);
   end

   else begin
     `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is not equal"),UVM_HIGH);
   end
  
  // //verifying pready in master and slave 
  // if(apb_slave_tx_h.pready == apb_master_tx_h.pready) begin
  //   `uvm_info(get_type_name(),$sformatf("apb_pready from master and slave is equal"),UVM_HIGH);
  // end

  // else begin
  //   `uvm_info(get_type_name(),$sformatf("apb_pready from master and slave is not equal"),UVM_HIGH);
  // end

  ////verifying pslverr in master and slave 
  // if(apb_slave_tx_h.pslverr == apb_master_tx_h.pslverr) begin
  //   `uvm_info(get_type_name(),$sformatf("apb_pslverr from master and slave is equal"),UVM_HIGH);
  // end

  // else begin
  //   `uvm_info(get_type_name(),$sformatf("apb_pslverr from master and slave is not equal"),UVM_HIGH);
  // end

 end

endtask : run_phase


//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  // TODO(mshariff): Banner as discussed
  `uvm_info (get_type_name(),$sformatf(" Scoreboard Check Phase is starting"),UVM_HIGH); 

// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error
  
  if ((byte_data_cmp_verified_master_tx_count != 0)&&(byte_data_cmp_failed_master_tx_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all master_tx comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_master_tx_count :%0d",
                                            byte_data_cmp_verified_master_tx_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_master_tx_count : %0d", 
                                            byte_data_cmp_failed_master_tx_count),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("comparisions of master_tx not happened"));
  end

  if ((byte_data_cmp_verified_slave_tx_count != 0)&&(byte_data_cmp_failed_slave_tx_count == 0) ) begin
	  `uvm_info (get_type_name(), $sformatf ("all slave_tx comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_slave_tx_count :%0d",
                                            byte_data_cmp_verified_slave_tx_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_slave_tx_count : %0d", 
                                            byte_data_cmp_failed_slave_tx_count),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("comparisions of master_tx not happened"));

  end

// 2. Check if master packets received are same as slave packets received
//    To Make sure that we have equal number of master and slave packets
  
 if (apb_master_tx_count == apb_slave_tx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("master and slave have equal no. of transactions"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("apb_master_tx_count : %0d",apb_master_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("apb_slave_tx_count : %0d",apb_slave_tx_count ),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("master and slave doesnot have same no. of transactions"));
  end 


// 3. Analyis fifos must be zero - This will indicate that all the packets have been compared
//    This is to make sure that we have taken all packets from both FIFOs and made the
//    comparisions
   
  if (apb_master_analysis_fifo.size() == 0)begin
    // TODO(mshariff): Chnage the info's to errors
     `uvm_info (get_type_name(), $sformatf ("APB Master analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("apb_master_analysis_fifo:%0d",apb_master_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("apb Master analysis FIFO is not empty"));
  end
  if (apb_slave_analysis_fifo.size()== 0)begin
    // TODO(mshariff): Chnage the info's to errors
     `uvm_info (get_type_name(), $sformatf ("APB Slave analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("apb_slave_analysis_fifo:%0d",apb_slave_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("APB Slave analysis FIFO is not empty"));
  end

endfunction : check_phase
  

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info("scoreboard",$sformatf("Scoreboard Report"),UVM_HIGH);
  
  // TODO(mshariff): Print the below items:
  // TODO(mshariff): Banner as discussed
  `uvm_info (get_type_name(),$sformatf(" Scoreboard Report Phase is starting"),UVM_HIGH); 
  // Total number of packets received from the Master
  `uvm_info (get_type_name(),$sformatf("No. of transactions from master:%0d",
                             apb_master_tx_count),UVM_HIGH);

  //Total number of packets received from the Slave (with their ID)
  `uvm_info (get_type_name(),$sformatf("No. of transactions from slave:%0d", 
                             apb_slave_tx_count),UVM_HIGH);
  
  
  //Number of master_tx comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise master_tx comparisions passed:%0d",
                byte_data_cmp_verified_master_tx_count),UVM_HIGH);

  //Number of slave_tx comparisios passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise slave_tx comparisions passed:%0d",
                byte_data_cmp_verified_slave_tx_count),UVM_HIGH);
  
  //Number of master_tx compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise master_tx comparision failed:%0d",
                byte_data_cmp_failed_master_tx_count),UVM_HIGH);

  //Number of slave_tx compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise slave_tx comparision failed:%0d",
                byte_data_cmp_failed_slave_tx_count),UVM_HIGH);

endfunction : report_phase



`endif

