`timescale 1ns / 1ps
`include "interconnect.vh"

`define Nb $clog2(N_SLAVES)

module split
  #(
    parameter N_SLAVES = 2, //number of slaves
    parameter P_SLAVES = `REQ_W-2, //slave select word msb position
    parameter DATA_W = 32,
    parameter ADDR_W = 32
    )
   (
    //masters interface
    input [`REQ_W-1:0]               m_req,
    output reg [`RESP_W-1:0]         m_resp,

    //slave interface
    //input [$clog2(N_SLAVES):0]       s_sel,
    output reg [N_SLAVES*`REQ_W-1:0] s_req,
    input [N_SLAVES*`RESP_W-1:0]     s_resp
    );
   
   //mask select bit MSB
   wire [`Nb:0]                      s_sel_int = m_req[P_SLAVES+1:P_SLAVES+1-`Nb] & {1'b0, {`Nb{1'b1}}};
   
                             
   //deliver request to selected slave
   integer                        i;
   always @* begin
      for (i=0; i<N_SLAVES; i=i+1)
        if(i == s_sel_int)
          //delete master request to slave
          s_req[`req(i)] = m_req;
        else
          //delete slave request
          s_req[`req(i)] = {(`REQ_W){1'b0}};
   end

   //route selected slave response to master
   integer                       j;
   always @* begin
      m_resp = {(`RESP_W){1'b0}};
      for (j=0; j<N_SLAVES; j=j+1)
        if(j == s_sel_int )
          m_resp = s_resp[`resp(j)];
   end
   
endmodule
