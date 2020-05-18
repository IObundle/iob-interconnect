`timescale 1ns / 1ps

`include "interconnect.vh"

module split
  #(
    parameter N_SLAVES = 2,
    parameter ADDR_W = 32
    )
   (
    //masters interface
    input [`BUS_REQ_W(ADDR_W)-1:0]                            m_req,
    output [`BUS_RESP_W-1:0]                                  m_resp,

    //slave interface
    output [N_SLAVES*`BUS_REQ_W(ADDR_W-$clog2(N_SLAVES))-1:0] s_req,
    input [N_SLAVES*`BUS_RESP_W-1:0]                          s_resp
    );


   parameter N_SLAVES_W = $clog2(N_SLAVES);
   parameter DADDR_W = ADDR_W-N_SLAVES_W;
   
   wire [N_SLAVES_W-1:0]                                          split_bits =  m_req[`BUS_REQ_W(ADDR_W)-2 -: N_SLAVES_W];

   //create and assign cat master buses
   `bus_cat(m, ADDR_W, 1)
   assign m[`req(ADDR_W, 0, 1)] = m_req;
   assign m_resp = m[`resp(0)];

   //create and assign cat slave bus
   `bus_cat(s, DADDR_W, N_SLAVES)
   assign s_req = s[`req_all(DADDR_W, N_SLAVES)];
   assign s[`resp_all(N_SLAVES)] = s_resp;

   //null bus for unselected slaves
   `bus_cat(m_null, DADDR_W, 1)
   assign m_null[`req(DADDR_W, 1, 0)] = {`BUS_REQ_W(DADDR_W){1'b0}};
   assign m_null[`resp(0)] = {`BUS_RESP_W{1'bz}};


   //do the split
   genvar                                                               i;

   generate 
      //demux output
      for (i=0; i<N_SLAVES; i=i+1) begin : demux_out
         
         assign s[`req(DADDR_W, N_SLAVES, i)] = (i==split_bits)? 
                                                    `get_req_naddrbits(m, DADDR_W, ADDR_W, 1, 0):
                                                    `get_req(m_null, DADDR_W, 1, 0);
         assign `get_resp(m, 0) = (i==split_bits)? `get_resp(s, i) : `get_resp(m_null, 0);
      end
   endgenerate

endmodule
