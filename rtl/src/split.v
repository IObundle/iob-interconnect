`timescale 1ns / 1ps

`include "interconnect.vh"

module split
  #(
    parameter TYPE = `D,
    parameter N_SLAVES = 2,
    parameter ADDR_W = 32,
    parameter E_ADDR_W = 1
    )
   (
    //extra split bits 
    input [E_ADDR_W-1:0]                                                m_e_addr,
    //masters interface
    input [`BUS_REQ_W(TYPE, ADDR_W)-1:0]                                m_req,
    output reg [`BUS_RESP_W-1:0]                                        m_resp,

    //slave interface
    output reg [N_SLAVES*`BUS_REQ_W(TYPE, ADDR_W-$clog2(N_SLAVES))-1:0] s_req,
    input [N_SLAVES*`BUS_RESP_W-1:0]                                    s_resp
    );


   parameter N_SLAVES_W = $clog2(N_SLAVES);

   //build split bits;
   wire [E_ADDR_W+N_SLAVES_W-1:0]                split_bits = E_ADDR_W?
                                                 {m_e_addr, m_req[`BUS_REQ_W(TYPE, ADDR_W)-2 -: N_SLAVES_W]}:
                                                 m_req[`BUS_REQ_W(TYPE, ADDR_W)-2 -: N_SLAVES_W];

   //create and assign cat master bus
   `bus_cat(TYPE, m, ADDR_W, 1)
   assign `get_req(`D, m, `ADDR_W, 1, 0) = m_req;
   assign m_resp = `get_resp(m, 0);
   
   //create and assign cat slave bus
   `bus_cat(TYPE, s, ADDR_W-N_SLAVES_W, N_SLAVES)
   assign s_req = `get_req_all(`D, s, ADDR_W-N_SLAVES_W, N_SLAVES);
   assign `get_resp_all(s, N_SLAVES) = s_resp;

   //create narrower master bus to drive slaves
   `bus_cat(TYPE, m_narrow, ADDR_W-N_SLAVES_W, 1)

   generate
      if(TYPE == `I) begin : type_i
        `connect_2narrower_i(m, ADDR_W, m_narrow, ADDR_W-N_SLAVES_W)
      end else begin : type_d
        `connect_2narrower_d(m, ADDR_W, m_narrow, ADDR_W-N_SLAVES_W)
      end
   endgenerate

   //do the split
   genvar                                             i;
   generate 
      //demux output
      for (i=0; i<(N_SLAVES*(2**E_ADDR_W)); i=i+1) begin : demux_out
         assign `get_req(TYPE, s, ADDR_W-N_SLAVES_W, N_SLAVES, i) = (split_bits == i[E_ADDR_W+N_SLAVES_W-1:0])? 
                                                                    `get_req(TYPE, m_narrow, ADDR_W-N_SLAVES_W, 1, 0):
                                                                    {`BUS_REQ_W(TYPE,ADDR_W-N_SLAVES_W){1'b0}};
         assign `get_resp(m, 0) = (split_bits == i[E_ADDR_W+N_SLAVES_W-1:0])? `get_resp(s, i) : {`BUS_RESP_W{1'bz}};
      end
   endgenerate
   
endmodule
