`timescale 1ns / 1ps
`include "interconnect.vh"

module merge
  #(
    parameter TYPE = `D,
    parameter N_MASTERS = 2,
    parameter ADDR_W = 32,
    parameter DATA_W = 32,
    )
   (
    //masters interface
    input [N_MASTERS*`BUS_REQ_W(TYPE, ADDR_W)-1:0] m_req,
    output [N_MASTERS*`BUS_RESP_W-1:0]             m_resp,

    //slave interface
    output [`BUS_REQ_W(TYPE, ADDR_W)-1:0]          s_req,
    input [`BUS_RESP_W-1:0]                        s_resp
    );

   integer                          i;

   //priority encoder most significant bus has priority   
   always @* begin
      reg [$clog2(N_MASTERS)-1:0]      ptr=0;
      for (i=0; i<N_MASTERS; i=i+1)
        if(get_valid(TYPE, m_req, ADDR_W, i)) //test valid bit 
          ptr = i[$clog2(N_MASTERS)-1:0]; //update pointer
   end

   assign s_req = `get_req(TYPE, {m_req, m_resp}, ADDR_W, N_MASTERS, ptr);   
   assign m_resp = `get_resp({m_resp, ptr);
      
endmodule
