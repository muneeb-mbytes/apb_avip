`ifndef APB_SCOREBOARD_INCLUDED_
`define APB_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_scoreboard
// Used to compare the data sent/received by the master with the slave's data sent/received
//--------------------------------------------------------------------------------------------
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  //Variable: apb_master_tx_h
  //Declaring handle for apb_master_tx
  apb_master_tx apb_master_tx_h;

  //Variable: apb_slave_tx_h
  //Declaring handle for apb_slaver_tx
  apb_slave_tx apb_slave_tx_h;
  
  //Variable: apb_master_analysis_fifo
  //Used to store the apb_master_data
  uvm_tlm_analysis_fifo#(apb_master_tx) apb_master_analysis_fifo;

  //Variable: apb_slave_analysis_fifo
  //Used to store the apb_slave_data
  uvm_tlm_analysis_fifo#(apb_slave_tx) apb_slave_analysis_fifo[];

  //Variable: apb_master_tx_count
  //To keep track of number of transactions for master 
  int apb_master_tx_count = 0;

  //Variable: apb_slave_tx_count
  //To keep track of number of transactions for slave 
  int apb_slave_tx_count = 0;

  //Variable: byte_data_cmp_verified_master_pwdata_count
  //To keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_pwdata_count = 0;

  //Variable: byte_data_cmp_failed_master_pwdata_count
  //to keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_pwdata_count = 0;

  //Variable: byte_data_cmp_verified_master_paddr_count
  //To keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_paddr_count = 0;

  //Variable: byte_data_cmp_failed_master_paddr_count
  //To keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_paddr_count = 0;

  //Variable: byte_data_cmp_verified_master_pwrite_count
  //To keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_pwrite_count = 0;

  //Variable: byte_data_cmp_failed_master_pwrite_count
  //To keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_pwrite_count = 0;

  //Variable: byte_data_cmp_verified_slave_prdata_count
  //To keep track of number of byte wise compared verified slave_tx_data
  int byte_data_cmp_verified_slave_prdata_count = 0;

  //Variable: byte_data_cmp_failed_slave_prdata_count
  //To keep track of number of byte wise compared failed slave_tx_data
  int byte_data_cmp_failed_slave_prdata_count = 0;

  //Variable: byte_data_cmp_verified_slave_pprot_count
  //Used to keep track of comparision verified pprot count
  int byte_data_cmp_verified_master_pprot_count;
  
  //Variable: byte_data_cmp_failed_slave_pprot_count
  //Used to keep track of comparision failed pprot count
  int byte_data_cmp_failed_master_pprot_count;
  
  //Variable: index
  //Used to note the slave number 
  bit index;

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
  apb_slave_analysis_fifo = new[NO_OF_SLAVES];
  
  foreach(apb_slave_analysis_fifo[i]) begin
    apb_slave_analysis_fifo[i] = new($sformatf("apb_slave_analysis_fifo[%0d]",i),this);
  end
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
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
 
  `uvm_info(get_type_name(),$sformatf("before calling master's analysis fifo get method"),UVM_HIGH)
  apb_master_analysis_fifo.get(apb_master_tx_h);
  apb_master_tx_count++;
  
  `uvm_info(get_type_name(),$sformatf("after calling master's analysis fifo get method"),UVM_HIGH) 
  `uvm_info(get_type_name(),$sformatf("printing apb_master_tx_h, \n %s",apb_master_tx_h.sprint()),UVM_HIGH)
  `uvm_info(get_type_name(),$sformatf("before calling slave's analysis_fifo"),UVM_HIGH)
  
  for(int i=0;i<NO_OF_SLAVES;i++) begin
    if(apb_master_tx_h.pselx[i]==1) begin
      index = i;
      break;
    end
  end
  
  apb_slave_analysis_fifo[index].get(apb_slave_tx_h);
  apb_slave_tx_count++;
  
  `uvm_info(get_type_name(),$sformatf("after calling slave's analysis fifo get method"),UVM_HIGH) 
  `uvm_info(get_type_name(),$sformatf("printing apb_slave_tx_h, \n %s",apb_slave_tx_h.sprint()),UVM_HIGH)
  
  //-------------------------------------------------------
  // Data comparision for master
  //-------------------------------------------------------
   
  `uvm_info(get_type_name(),$sformatf("--\n-----------------------------------------------SCOREBOARD COMPARISIONS--------------------------------------------------"),UVM_HIGH) 

  //-------------------------------------------------------
  // Verifying pwdata in master and slave 
  //-------------------------------------------------------
  if(apb_master_tx_h.pwdata == apb_slave_tx_h.pwdata) begin
    `uvm_info(get_type_name(),$sformatf("apb_pwdata from master and slave is equal"),UVM_HIGH);
    `uvm_info("SB_PWDATA_MATCHED", $sformatf("Master PWDATA = 'h%0x and Slave PWDATA = 'h%0x",
                                    apb_master_tx_h.pwdata,apb_slave_tx_h.pwdata), UVM_HIGH);             
    byte_data_cmp_verified_master_pwdata_count++;
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("apb_pwdata from master and slave is not equal"),UVM_HIGH);
    `uvm_error("ERROR_SC_PWDATA_MISMATCH", $sformatf("Master PWDATA = 'h%0x and Slave PWDATA = 'h%0x",
                                            apb_master_tx_h.pwdata,apb_slave_tx_h.pwdata));
    byte_data_cmp_failed_master_pwdata_count++;
  end
  
  //-------------------------------------------------------
  // Verifying paddr in master and slave 
  //-------------------------------------------------------
  if(apb_master_tx_h.paddr == apb_slave_tx_h.paddr) begin
    `uvm_info(get_type_name(),$sformatf("apb_paddr from master and slave is equal"),UVM_HIGH);
    `uvm_info("SB_PADDR_MATCH", $sformatf("Master PADDR = 'h%0x and Slave PADDR = 'h%0x",
                                apb_master_tx_h.pwdata,apb_slave_tx_h.pwdata), UVM_HIGH);             
    byte_data_cmp_verified_master_paddr_count++;
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("apb_paddr from master and slave is not equal"),UVM_HIGH);
    `uvm_error("ERROR_SC_PADDR_MISMATCH", $sformatf("Master PADDR = 'h%0x and Slave PADDR = 'h%0x",
                                          apb_master_tx_h.paddr,apb_slave_tx_h.paddr));
    byte_data_cmp_failed_master_paddr_count++;
  end

  //-------------------------------------------------------
  // Verifying pwrite in master and slave 
  //-------------------------------------------------------
  if(apb_master_tx_h.pwrite == apb_slave_tx_h.pwrite) begin
    `uvm_info(get_type_name(),$sformatf("apb_pwrite from master and slave is equal"),UVM_HIGH);
    `uvm_info("SB_PWRITE_MATCH", $sformatf("Master PWRITE = 'h%0x and Slave PWRITE = 'h%0x",
                                  apb_master_tx_h.pwrite,apb_slave_tx_h.pwrite), UVM_HIGH);
    byte_data_cmp_verified_master_pwrite_count++;
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("apb_pwrite from master and slave is not equal"),UVM_HIGH);
    `uvm_error("ERROR_SC_PWRITE_MISMATCH", $sformatf("Master PWRITE = 'h%0x and Slave PWRITE = 'h%0x",
                                            apb_master_tx_h.pwrite,apb_slave_tx_h.pwrite));
    byte_data_cmp_failed_master_pwrite_count++;
  end

  //-------------------------------------------------------
  // Data comparision for slave
  //-------------------------------------------------------
   
  //-------------------------------------------------------
  // Verifying prdata in master and slave 
  //-------------------------------------------------------
  if(apb_slave_tx_h.prdata == apb_master_tx_h.prdata) begin
    `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is equal"),UVM_HIGH);
    `uvm_info("SB_PRDATA_MATCHED", $sformatf("Master PRDATA = 'h%0x and Slave PRDATA = 'h%0x",
                                    apb_master_tx_h.prdata,apb_slave_tx_h.prdata), UVM_HIGH);
    byte_data_cmp_verified_slave_prdata_count++;
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is not equal"),UVM_HIGH);
    `uvm_error("ERROR_SC_PRDATA_MISMATCH", $sformatf("Master PRDATA = 'h%0x and Slave PRDATA = 'h%0x",
                                            apb_master_tx_h.prdata,apb_slave_tx_h.prdata));
    byte_data_cmp_failed_slave_prdata_count++;
  end

  //-------------------------------------------------------
  // Verifying pprot in master and slave 
  //-------------------------------------------------------
  if(apb_slave_tx_h.pprot == apb_master_tx_h.pprot) begin
    `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is equal"),UVM_HIGH);
    `uvm_info("SB_PPROT_MATCHED", $sformatf("Master PPROT = 'h%0x and Slave PPROT = 'h%0x",
                                  apb_master_tx_h.pprot,apb_slave_tx_h.pprot), UVM_HIGH);
    byte_data_cmp_verified_master_pprot_count++;
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("apb_prdata from master and slave is not equal"),UVM_HIGH);
    `uvm_error("ERROR_SC_PRDATA_MISMATCH", $sformatf("Master PPROT = %s and Slave PPROT = %s",
                                            apb_master_tx_h.pprot.name(),apb_slave_tx_h.pprot.name()));
    byte_data_cmp_failed_master_pprot_count++;
  end

  `uvm_info(get_type_name(),$sformatf("--\n-----------------------------------------------END OF SCOREBOARD COMPARISIONS---------------------------------------"),UVM_HIGH) 
 end

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
//  Display the result of simulation
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  `uvm_info(get_type_name(),$sformatf("--\n----------------------------------------------SCOREBOARD CHECK PHASE---------------------------------------"),UVM_HIGH) 
  `uvm_info (get_type_name(),$sformatf(" Scoreboard Check Phase is starting"),UVM_HIGH); 

  //--------------------------------------------------------------------------------------------
  //1. Checks if the comparisions counter is NON-zero
  //   A non-zero value indicates that the comparisions never happened and throw error
  //--------------------------------------------------------------------------------------------
  if ((byte_data_cmp_verified_master_pwdata_count != 0) && (byte_data_cmp_failed_master_pwdata_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all master_pwdata comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_master_pwdata_count :%0d",
                                            byte_data_cmp_verified_master_pwdata_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_master_pwdata_count : %0d", 
                                            byte_data_cmp_failed_master_pwdata_count),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("comparisions of master_pwdata not happened"));
  end

  if ((byte_data_cmp_verified_master_paddr_count != 0) && (byte_data_cmp_failed_master_paddr_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all master_paddr comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_master_paddr_count :%0d",
                                            byte_data_cmp_verified_master_paddr_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_master_paddr_count : %0d", 
                                            byte_data_cmp_failed_master_paddr_count),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("comparisions of master_paddr not happened"));
  end

  if ((byte_data_cmp_verified_master_pwrite_count != 0) && (byte_data_cmp_failed_master_pwrite_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all master_pwrite comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_master_pwrite_count :%0d",
                                            byte_data_cmp_verified_master_pwrite_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_master_pwrite_count : %0d", 
                                            byte_data_cmp_failed_master_pwrite_count),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("comparisions of master_pwrite not happened"));
  end

  if ((byte_data_cmp_verified_slave_prdata_count != 0) && (byte_data_cmp_failed_slave_prdata_count == 0) ) begin
	  `uvm_info (get_type_name(), $sformatf ("all slave_prdata comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_slave_prdata_count :%0d",
                                            byte_data_cmp_verified_slave_prdata_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_slave_prdata_count : %0d", 
                                            byte_data_cmp_failed_slave_prdata_count),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("comparisions of master_prdata not happened"));
  end

  //--------------------------------------------------------------------------------------------
  //2. Checks if master packets received are same as slave packets received
  //   To Make sure that we have equal number of master and slave packets
  //--------------------------------------------------------------------------------------------
  if (apb_master_tx_count == apb_slave_tx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("master and slave have equal no. of transactions"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("apb_master_tx_count : %0d",apb_master_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("apb_slave_tx_count : %0d",apb_slave_tx_count ),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("master and slave doesnot have same no.of transactions"));
  end 

  //--------------------------------------------------------------------------------------------
  //3. Analysis fifos must be zero - This will indicate that all the packets have been compared
  //   This is to make sure that we have taken all packets from both FIFOs and made the
  //   comparisions
  //--------------------------------------------------------------------------------------------
  if(apb_master_analysis_fifo.size() == 0)begin
    `uvm_info ("SC_CheckPhase", $sformatf ("APB Master analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("apb_master_analysis_fifo:%0d",apb_master_analysis_fifo.size() ),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("apb Master analysis FIFO is not empty"));
  end
  if(apb_slave_analysis_fifo[index].size()== 0)begin
    `uvm_info ("SC_CheckPhase", $sformatf ("APB Slave analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("apb_slave_analysis_fifo:%0d",apb_slave_analysis_fifo[index].size()),UVM_HIGH);
    `uvm_error ("SC_CheckPhase",$sformatf ("APB Slave analysis FIFO is not empty"));
  end

  `uvm_info(get_type_name(),$sformatf("--\n----------------------------------------------END OF SCOREBOARD CHECK PHASE---------------------------------------"),UVM_HIGH)

endfunction : check_phase
  
//--------------------------------------------------------------------------------------------
// Function: report_phase
//  Display the result of simulation
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info("scoreboard",$sformatf("--\n--------------------------------------------------Scoreboard Report-----------------------------------------------"),UVM_HIGH);
  
  `uvm_info (get_type_name(),$sformatf(" Scoreboard Report Phase is starting"),UVM_HIGH); 
  
  //Total number of packets received from the Master
  `uvm_info (get_type_name(),$sformatf("No. of transactions from master:%0d",
                             apb_master_tx_count),UVM_HIGH);

  //Total number of packets received from the Slave (with their ID)
  `uvm_info (get_type_name(),$sformatf("No. of transactions from slave:%0d", 
                             apb_slave_tx_count),UVM_HIGH);
  
  //Number of master_pwdata comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise master_pwdata comparisions passed:%0d",
                             byte_data_cmp_verified_master_pwdata_count),UVM_HIGH);

   //Number of master_paddr comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise master_paddr comparisions passed:%0d",
                             byte_data_cmp_verified_master_paddr_count),UVM_HIGH);

  //Number of master_pwrite comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise master_pwrite comparisions passed:%0d",
                             byte_data_cmp_verified_master_pwrite_count),UVM_HIGH);

  //Number of slave_prdata comparisios passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise slave_prdata comparisions passed:%0d",
                             byte_data_cmp_verified_slave_prdata_count),UVM_HIGH);
  
  //Number of master_pwdata compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise master_pwdata comparision failed:%0d",
                             byte_data_cmp_failed_master_pwdata_count),UVM_HIGH);

  //Number of master_paddr compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise master_paddr comparision failed:%0d",
                             byte_data_cmp_failed_master_paddr_count),UVM_HIGH);

  //Number of master_pwrite compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise master_pwrite comparision failed:%0d",
                             byte_data_cmp_failed_master_pwrite_count),UVM_HIGH);

  //Number of slave_prdata compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise slave_prdata comparision failed:%0d",
                             byte_data_cmp_failed_slave_prdata_count),UVM_HIGH);

  `uvm_info("scoreboard",$sformatf("--\n--------------------------------------------------End of Scoreboard Report-----------------------------------------------"),UVM_HIGH);

endfunction : report_phase

`endif

