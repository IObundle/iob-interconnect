/*

Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * AXI4-Lite RAM
 */
module axil2native_adapter #
  (
   // Width of data bus in bits
   parameter DATA_WIDTH = 32,
   // Width of address bus in bits
   parameter ADDR_WIDTH = 32,
   // Width of wstrb (width of data bus in words)
   parameter STRB_WIDTH = (DATA_WIDTH/8)
   )
   (
    input wire 			clk,
    input wire 			rst,
    
    // AXI4-lite slave interface
    input [ADDR_WIDTH-1:0] 	s_axil_awaddr,
    input [2:0] 		s_axil_awprot,
    input 			s_axil_awvalid,
    output 			s_axil_awready,
    
    input [DATA_WIDTH-1:0] 	s_axil_wdata,
    input [STRB_WIDTH-1:0] 	s_axil_wstrb,
    input 			s_axil_wvalid,
    output 			s_axil_wready,
    
    output [1:0] 		s_axil_bresp,
    output 			s_axil_bvalid,
    input 			s_axil_bready,
    
    input [ADDR_WIDTH-1:0] 	s_axil_araddr,
    input [2:0] 		s_axil_arprot,
    input 			s_axil_arvalid,
    output 			s_axil_arready,
    
    output [DATA_WIDTH-1:0] 	s_axil_rdata,
    output [1:0] 		s_axil_rresp,
    output 			s_axil_rvalid,
    input 			s_axil_rready,
    
    // Native interface
    output 			native_valid,
    input 			native_ready,
    output [ADDR_WIDTH-1:0] 	native_addr,
    output reg [DATA_WIDTH-1:0] native_wdata,
    output reg [STRB_WIDTH-1:0] native_wstrb,
    input [DATA_WIDTH-1:0] 	native_rdata 
    );
      
   reg 			    wr_en, rd_en;
   
   reg 			    s_axil_awready_reg = 1'b0, s_axil_awready_next;
   reg 			    s_axil_wready_reg = 1'b0, s_axil_wready_next;
   reg 			    s_axil_bvalid_reg = 1'b0, s_axil_bvalid_next;
   reg 			    s_axil_arready_reg = 1'b0, s_axil_arready_next;
   reg [DATA_WIDTH-1:0]     s_axil_rdata_reg = {DATA_WIDTH{1'b0}}, s_axil_rdata_next;
   reg 			    s_axil_rvalid_reg = 1'b0, s_axil_rvalid_next;
   
   wire [VALID_ADDR_WIDTH-1:0] s_axil_awaddr_valid = s_axil_awaddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
   wire [VALID_ADDR_WIDTH-1:0] s_axil_araddr_valid = s_axil_araddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
   
   assign s_axil_awready = s_axil_awready_reg;
   assign s_axil_wready = s_axil_wready_reg;
   assign s_axil_bresp = 2'b00;
   assign s_axil_bvalid = s_axil_bvalid_reg;
   assign s_axil_arready = s_axil_arready_reg;
   assign s_axil_rdata = s_axil_rdata_reg;
   assign s_axil_rresp = 2'b00;
   assign s_axil_rvalid = s_axil_rvalid_reg;
   
   //WRITE
   always @* begin
      wr_en = 1'b0;
      native_wstrb = {STRB_WIDTH{1'b0}};
      
      s_axil_awready_next = 1'b0;
      s_axil_wready_next = 1'b0;
      s_axil_bvalid_next = s_axil_bvalid_reg && !s_axil_bready;
      
      if (s_axil_awvalid && s_axil_wvalid && (!s_axil_bvalid || s_axil_bready) && (!s_axil_awready && !s_axil_wready)) begin
         s_axil_awready_next = 1'b1;
         s_axil_wready_next = 1'b1;
         s_axil_bvalid_next = 1'b1;
	 
         native_wstrb = s_axil_wstrb;
	 wr_en = 1'b1;
      end
   end
   
   always @(posedge clk) begin
      if (rst) begin
         s_axil_awready_reg <= 1'b0;
         s_axil_wready_reg <= 1'b0;
         s_axil_bvalid_reg <= 1'b0;
      end else begin
         s_axil_awready_reg <= s_axil_awready_next;
         s_axil_wready_reg <= s_axil_wready_next;
         s_axil_bvalid_reg <= s_axil_bvalid_next;
      end

      native_wdata_reg <= s_axil_wdata;
   end

   //READ
   always @* begin
      rd_en = 1'b0;
      s_axil_arready_next = 1'b0;
      s_axil_rvalid_next = s_axil_rvalid_reg && !s_axil_rready && !s_axil_wvalid && !s_axil_awvalid;
      
      if (s_axil_arvalid && (!s_axil_rvalid || s_axil_rready) && !s_axil_arready && !s_axil_wvalid && !s_axil_awvalid) begin
         s_axil_arready_next = 1'b1;
         s_axil_rvalid_next = 1'b1;

	 rd_en = 1'b1;
      end
   end
   
   always @(posedge clk) begin
    if (rst) begin
       s_axil_arready_reg <= 1'b0;
       s_axil_rvalid_reg <= 1'b0;
    end else begin
       s_axil_arready_reg <= s_axil_arready_next;
       s_axil_rvalid_reg <= s_axil_rvalid_next;
    end
      
      s_axil_rdata_reg <= native_rdata;
   end // always @ (posedge clk)

   //ADDRESS MUX
   always @(posedge clk) begin
      if (rst)
	native_addr <= {ADDR_WIDTH{1'b0}};
      else if (wr_en) begin
	 native_addr <= s_axil_awaddr;
	 native_valid <= s_axil_wvalid;
      end
      else
	native_addr <= s_axil_araddr;
   end
   
endmodule
