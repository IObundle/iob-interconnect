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
    output reg [`REQ_W-1:0]            s_req,
    input [`RESP_W-1:0]                s_resp
    );

   integer                          i;

   //priority encoder: most significant bus has priority   
   always @* begin
      s_req = 1'b0;
      m_resp = {N_MASTERS*`RESP_W{1'b0}};
      for (i=0; i<N_MASTERS; i=i+1)
        if(m_req[`valid(i)]) begin //test valid bit 
           s_req = m_req[`req(i)];
           m_resp[`resp(i)] = s_resp;
        end
   end

endmodule
