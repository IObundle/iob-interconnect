`timescale 1ns / 1ps

`include "interconnect.vh"

module split
  #(
    parameter TYPE = `D,
    parameter N_SLAVES = 2,
    parameter ADDR_W = 32,
    parameter E_ADDR_W = 0
    )
   (
    //extra split bits 
    input [E_ADDR_W-1:0]                                                         m_e_addr,
    //masters interface
    input [`BUS_REQ_W(TYPE, ADDR_W)-1:0]                                         m_req,
    output reg [`BUS_RESP_W-1:0]                                                 m_resp,

    //slave interface
    output reg [N_SLAVES*`BUS_REQ_W(TYPE, ADDR_W+E_ADDR_W-$clog2(N_SLAVES))-1:0] s_req,
    input [N_SLAVES*`BUS_RESP_W-1:0]                                             s_resp
    );


   parameter N_SLAVES_W = $clog2(N_SLAVES);
   parameter ADDRN_W = ADDR_W-N_SLAVES_W+E_ADDR_W;
   
   //build split bits;
   wire [N_SLAVES_W-1:0]                                                split_bits;

   assign split_bits = (E_ADDR_W ==  N_SLAVES_W)? m_e_addr : (!E_ADDR_W)?
                       m_req[`BUS_REQ_W(TYPE, ADDR_W)-2 : `BUS_REQ_W(TYPE, ADDR_W)-2-N_SLAVES_W]:
                       {m_e_addr, m_req[`BUS_REQ_W(TYPE, ADDR_W)-2 : `BUS_REQ_W(TYPE, ADDR_W)-2-N_SLAVES_W+E_ADDR_W]};


   //create and assign cat master buses
   `bus_cat(TYPE, m, ADDR_W, 1)
   assign `get_req(TYPE, m, ADDR_W, 1, 0) = m_req;
   assign m_resp = `get_resp(m, 0);

   //create and assign cat slave bus
   `bus_cat(TYPE, s, ADDRN_W, N_SLAVES)
   assign s_req = `get_req_all(TYPE, s, ADDRN_W, N_SLAVES);
   assign `get_resp_all(s, N_SLAVES) = s_resp;

   //create narrow slave control buses
   //master narrow copy
   `bus_cat(TYPE, m2s, ADDRN_W, 1)
   //connect master to narrow copy 
   generate
      if(TYPE == `D) begin
         assign `get_valid(`D, m2s, ADDRN_W, 1, 0) = `get_valid(`D, m, ADDR_W, 1, 0);
         assign `get_address(`D, m2s, ADDRN_W, 1, 0) = `get_narrow_address(`D, m, ADDR_W, ADDRN_W, 1, 0);
         assign `get_write(m2s, ADDRN_W, 1, 0) = `get_write(m, ADDR_W, 1, 0);
         assign `get_resp(m, 0) = `get_resp(m2s, 0);
      end else begin
         assign `get_valid(`I, m2s, ADDRN_W, 1, 0) = `get_valid(`I, m, ADDR_W, 1, 0);
         assign `get_address(`I, m2s, ADDRN_W, 1, 0) = `get_narrow_address(`I, m, ADDR_W, ADDRN_W, 1, 0);
         assign `get_resp(m, 0) = `get_resp(m2s, 0);
      end
   endgenerate
       
   //narrow null bus for unconnected peripherals
   `bus_cat(TYPE, m2s_null, ADDRN_W, 1)
   assign `get_req(TYPE, m2s_null, ADDRN_W, 1, 0) = {`BUS_REQ_W(TYPE, ADDRN_W){1'b0}};
   assign `get_resp(m2s_null, 0) = {`BUS_RESP_W{1'bz}};


   //do the split
   genvar                                                               i;

   generate 
      //demux output
      for (i=0; i<N_SLAVES; i=i+1) begin : demux_out
         assign `get_req(TYPE, s, ADDRN_W, N_SLAVES, i) = (i==split_bits)? 
                                                           `get_req(TYPE, m2s, ADDRN_W, 1, 0): 
                                                           `get_req(TYPE, m2s_null, ADDRN_W, 1, 0);
         assign `get_resp(m2s, 0) = (i==split_bits)? `get_resp(s, i) : `get_resp(m2s_null, 0);
      end
   endgenerate

endmodule
