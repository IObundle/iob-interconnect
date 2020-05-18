////////////////////////////////////////////////////////////////
// CONNECT
//

//connect source cat bus section to destination cat bus section
task connect_c2c();
   input [`BUS_REQ_W(SADDR_W)-1:0] SRC;
   input integer SADDR_W;
   input integer SN;
   input integer SI;
   output [`BUS_REQ_W(DADDR_W)-1:0] DEST;
   input integer                    DADDR_W;
   input integer                    DN;
   input integer                    DI;

   begin

      reg [DADDR_W-1:0] dest_addr;
      reg [SADDR_W-1:0] src_addr = SRC[`address(SADDR_W, SI, SN)];

      if(SADDR_W <= DADDR_W)
        dest_addr <= src_addr;
      else
        dest_addr <= src_addr[DADDR_W-1:0];
        
      DEST[`req(DADDR_W, DN, DI)] = {`valid(SADDR,DI,DN), dest_addr, `wdata(SADDR,DI,DN), `wstrb(SADDR,DI,DN)};
      SRC[`resp(SI)] = DEST[`resp(DI)];

   end
endtask

