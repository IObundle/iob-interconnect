//
// BUS INTERCONNECT MACROS
//


`define READYW 1
`define RDATAW `DATA_W
`define WSTRBW `DATA_W/8
`define WDATAW `DATA_W
`DEFINE ADDRW(SIZE) SIZE
`DEFINE VALIDW 1

`define READYP 0
`define RDATAP (`READYP+`READYW)
`define WSTRBP (`RDATAP+`RDATAW)
`define WDATAP (`WSTRBP+`WSTRBW)
`define ADDRP  (`WDATAP+`WDATAW)
`define VALIDP(SIZE) (`ADDRP+`ADDRW(SIZE))
              
//uncomment to parse independently
//`define DATA_W 32

//CONCAT BUS WIDTHS
//request part
`define BUS_REQ_W(ADDR_W) (`VALIDW+`ADDRW(ADDR_W)+`WDATAW+`WSTRBW)
//response part
`define BUS_RESP_W (`READYW+`RDATAW)
//whole
`define BUS_W(ADDR_W) (`BUS_REQ_W(ADDR_W)+`BUS_RESP_W)



///////////////////////////////////////////////////////////////////
//DECLARE
//

//cat bus
`define bus_cat(NAME, ADDR_W, N) wire [N*`BUS_W(ADDR_W)-1:0] NAME;


///////////////////////////////////////////////////////////////////////////////////
//GET FIELDS

//gets all the request part of cat bus x[`req_all(ADDR_W, N)]
`define req_all(ADDR_W,N) N*`BUS_W(ADDR_W)-1 -: N*`BUS_REQ_W(ADDR_W)
              
//gets all the response part of a cat bus x[`resp_all(N)]
`define resp_all(N) N*`BUS_RESP_W-1 : 0

//gets request section of cat bus
`define req(ADDR_W, I, N) N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W) +: `BUS_REQ_W(ADDR_W)

//gets the response part of a cat bus section
`define resp(I) I*`BUS_RESP_W +: `BUS_RESP_W

//gets the valid bit of cat bus section 
`define valid(ADDR_W, I, N) N*`BUS_RESP_W + I*`BUS_REQ_W(ADDR_W) + `VALIDP

//gets the address of cat bus section
`define address(ADDR_W, I, N) N*`BUS_RESP_W + I*`BUS_REQ_W(ADDR_W)+`ADDRP +: ADDR_W

//gets the wdata field of cat bus
`define wdata(ADDR_W, N, I) N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`DATAWP +: `DATA_W

//gets the wstrb field of cat bus
`define wstrb(ADDR_W, N, I) N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W) +: `WSTRBW

//gets the rdata field of cat bus
`define rdata(I) I*`BUS_RESP_W +: `DATA_W

//gets the ready field of cat bus
`define ready(I) I*`BUS_RESP_W

