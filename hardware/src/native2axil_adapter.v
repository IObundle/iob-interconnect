`timescale 1ns / 1ps

module native2axil_adapter #
  (
   // Width of data bus in bits
   parameter DATA_WIDTH = 32,
   // Width of address bus in bits
   parameter ADDR_WIDTH = 32,
   // Width of wstrb (width of data bus in words)
   parameter STRB_WIDTH = (DATA_WIDTH/8)
   )   
   (
    input 		    clk, rst,
    
    // AXI4-lite master interface
    
    output 		    m_axi_awvalid,
    input 		    m_axi_awready,
    output [ADDR_WIDTH-1:0] m_axi_awaddr,
    output [ 2:0] 	    m_axi_awprot,

    output 		    m_axi_wvalid,
    input 		    m_axi_wready,
    output [DATA_WIDTH-1:0] m_axi_wdata,
    output [STRB_WIDTH-1:0] m_axi_wstrb,

    input 		    m_axi_bvalid,
    output 		    m_axi_bready,

    output 		    m_axi_arvalid,
    input 		    m_axi_arready,
    output [ADDR_WIDTH-1:0] m_axi_araddr,
    output [ 2:0] 	    m_axi_arprot,

    input 		    m_axi_rvalid,
    output 		    m_axi_rready,
    input [DATA_WIDTH-1:0]  m_axi_rdata,

    // Native interface
    
    input 		    native_valid,
    input 		    native_instr,
    output 		    native_ready,
    input [ADDR_WIDTH-1:0]  native_addr,
    input [DATA_WIDTH-1:0]  native_wdata,
    input [STRB_WIDTH-1:0]  native_wstrb,
    output [DATA_WIDTH-1:0] native_rdata
    );
   
   reg 		  ack_awvalid;
   reg 		  ack_arvalid;
   reg 		  ack_wvalid;
   reg 		  xfer_done;
   
   assign m_axi_awvalid = native_valid && |native_wstrb && !ack_awvalid;
   assign m_axi_awaddr = native_addr;
   assign m_axi_awprot = 0;

   assign m_axi_arvalid = native_valid && !native_wstrb && !ack_arvalid;
   assign m_axi_araddr = native_addr;
   assign m_axi_arprot = native_instr ? 3'b100 : 3'b000;

   assign m_axi_wvalid = native_valid && |native_wstrb && !ack_wvalid;
   assign m_axi_wdata = native_wdata;
   assign m_axi_wstrb = native_wstrb;

   assign native_ready = m_axi_bvalid || m_axi_rvalid;
   assign m_axi_bready = native_valid && |native_wstrb;
   assign m_axi_rready = native_valid && !native_wstrb;
   assign native_rdata = m_axi_rdata;

   always @ *
     xfer_done <= native_valid && native_ready;
   
   always @(posedge clk) begin
      if (rst) begin
	 ack_awvalid <= 0;
      end else begin
	 if (m_axi_awready && m_axi_awvalid)
	   ack_awvalid <= 1;
	 if (m_axi_arready && m_axi_arvalid)
	   ack_arvalid <= 1;
	 if (m_axi_wready && m_axi_wvalid)
	   ack_wvalid <= 1;
	 if (xfer_done || !native_valid) begin
	    ack_awvalid <= 0;
	    ack_arvalid <= 0;
	    ack_wvalid <= 0;
	 end
      end
   end
endmodule
