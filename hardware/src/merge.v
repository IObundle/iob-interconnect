`timescale 1ns / 1ps
`include "interconnect.vh"

module merge
  #(
    parameter N_MASTERS = 2
    )
   (
    //masters interface
    input [N_MASTERS*`REQ_W-1:0]       m_req,
    output reg [N_MASTERS*`RESP_W-1:0] m_resp,

    //slave interface
    output [`REQ_W-1:0]                s_req,
    input [`RESP_W-1:0]                s_resp
    );

   integer                          i, j;
   integer                          ptr;

   //priority encoder: most significant bus has priority   
   always @* begin
      ptr = 0;
      for (i=0; i<N_MASTERS; i=i+1)
        if(m_req[`valid(i)]) //test valid bit 
          ptr = i; //update pointer
   end
 
   //slave request 
   assign s_req = m_req[`req(ptr)];
      
   //master response
   always @* begin
      m_resp = {N_MASTERS*`RESP_W{1'b0}};
      m_resp[`resp(ptr)] = s_resp;
   end

endmodule
