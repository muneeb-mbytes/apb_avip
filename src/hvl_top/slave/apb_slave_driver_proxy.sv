`ifndef APB_SLAVE_DRIVER_PROXY_INCLUDED_
`define APB_SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: apb_slave_driver_proxy
//  This is the proxy driver on the HVL side
//  It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class apb_slave_driver_proxy extends uvm_driver#(apb_slave_tx);
  `uvm_component_utils(apb_slave_driver_proxy)

  apb_slave_tx apb_slave_tx_h;

  // Variable: slave_driver_bfm_h;
  // Handle for slave driver bfm
  virtual apb_slave_driver_bfm apb_slave_drv_bfm_h;

  //  slave_spi_seq_item_converter  slave_spi_seq_item_conv_h;

  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  apb_slave_agent_config apb_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);


endclass : apb_slave_driver_proxy
  
//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - apb_slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function apb_slave_driver_proxy::new(string name = "apb_slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Slave_driver_bfm congiguration is obtained in build phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void apb_slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

//  if(!uvm_config_db #(apb_slave_agent_config)::get(this,"","apb_slave_agent_config",
  //                                               apb_slave_agent_cfg_h))
//		`uvm_fatal("CONFIG","cannot get() apb_slave_agent_cfg_h")
  		
  if(!uvm_config_db #(virtual apb_slave_driver_bfm)::get(this,"","apb_slave_driver_bfm",
                                                             apb_slave_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_SLAVE_DRIVER_BFM","cannot get() apb_slave_drv_bfm_h");
  end

  //  slave_spi_seq_item_conv_h = slave_spi_seq_item_converter::type_id::create
  //                                                    ("slave_spi_seq_item_conv_h");
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connects driver_proxy and driver_bfm
//
//  Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void apb_slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
//  apb_slave_drv_bfm_h = apb_slave_agent_cfg_h.apb_slave_drv_bfm_h;
endfunction : connect_phase


//-------------------------------------------------------
// Function: end_of_elaboration_phase
//Description: connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//-------------------------------------------------------
function void apb_slave_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  apb_slave_drv_bfm_h.apb_slave_drv_proxy_h = this;
endfunction : end_of_elaboration_phase



`endif
