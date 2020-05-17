`timescale 1ns / 1ps
`include "interconnect.vh"

module merge
  #(
    parameter N_MASTERS = 2,
    parameter ADDR_W = 32,
    parameter DATA_W = 32
    )
   (
    //masters interface
    input [N_MASTERS*`BUS_REQ_W(ADDR_W)-1:0] m_req,
    output reg [N_MASTERS*`BUS_RESP_W-1:0]   m_resp,

    //slave interface
    output [`BUS_REQ_W(ADDR_W)-1:0]          s_req,
    input [`BUS_RESP_W-1:0]                  s_resp
    );

   //cat master bus
   wire [N_MASTERS*`BUS_W(ADDR_W)-1:0] m = {m_req, m_resp};
   
   //cat slave bus
   wire [`BUS_W(ADDR_W)-1 : 0] s = {s_req, s_resp};
   
   integer                          i, j;
   integer                          ptr;

   //priority encoder: most significant bus has priority   
   always @* begin
      ptr = 0;
      for (i=0; i<N_MASTERS; i=i+1)
        if(`get_valid(m, ADDR_W, N_MASTERS, i)) //test valid bit 
          ptr = i; //update pointer
   end
 
   //slave request 
   assign s_req = `get_req(m, ADDR_W, N_MASTERS, ptr);   
      
   //master response
   always @* begin
      m_resp = {N_MASTERS*`BUS_RESP_W{1'b0}};
      `get_resp(m_resp, ptr) = s_resp;
   end

endmodule
