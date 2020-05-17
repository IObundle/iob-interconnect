//
// BUS INTERCONNECT MACROS
//

//uncomment to parse independently
`define DATA_W 32

//CONCAT BUS WIDTHS
//request part
`define BUS_REQ_W(ADDR_W) (1+ADDR_W+`DATA_W+`DATA_W/8)
//response part
`define BUS_RESP_W              (`DATA_W+1)
//whole
`define BUS_W(ADDR_W)     (`BUS_REQ_W(ADDR_W)+`BUS_RESP_W)

//UNCAT BUS SUFFIXES
`define valid _valid
`define addr  _addr
`define wdata _wdata
`define wstrb _wstrb
`define rdata _rdata
`define ready _ready

//TMP SUFFIX
`define tmp _tmp


///////////////////////////////////////////////////////////////////
//DECLARE
//

//cat bus
`define bus_cat(NAME, ADDR_W, N) wire [N*`BUS_W(ADDR_W)-1:0] NAME;

//uncat instruction bus
`define bus_uncat(NAME, ADDR_W)\
wire  NAME`valid;\
wire [ADDR_W-1:0] NAME`addr;\
wire [`DATA_W-1:0] NAME`wdata;\
wire [`DATA_W/8-1:0] NAME`wstrb;\
wire [`DATA_W-1:0] NAME`rdata;\
wire NAME`ready;


///////////////////////////////////////////////////////////////////////////////////
//GET FIELDS

//gets all the request part of cat bus
`define get_req_all(NAME, ADDR_W, N) NAME[N*`BUS_W(ADDR_W)-1 -: N*`BUS_REQ_W(ADDR_W)]

//gets all the response part of a cat bus
`define get_resp_all(NAME, N) NAME[N*`BUS_RESP_W-1 : 0]

//gets request section of cat bus
`define get_req(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W) +: `BUS_REQ_W(ADDR_W)]

//gets the response part of a cat bus section
`define get_resp(NAME, I) NAME[I*`BUS_RESP_W +: `BUS_RESP_W]

//gets the valid bit of cat bus section 
`define get_valid(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W + (I+1)*`BUS_REQ_W(ADDR_W)-1]

//gets the address of cat bus section 
`define get_address(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W + (I+1)*`BUS_REQ_W(ADDR_W)-2 -: ADDR_W]

//gets the wdata field of cat bus
`define get_wdata(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`DATA_W/8 +: `DATA_W]

//gets the wstrb field of cat bus
`define get_wstrb(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W) +: `DATA_W/8]

           //gets the rdata field of cat bus
`define get_rdata(NAME, I) NAME[I*`BUS_RESP_W +: `DATA_W]

           //gets the ready field of cat bus
`define get_ready(NAME, I) NAME[I*`BUS_RESP_W]

//gets the n lsbs of word
`define get_nbits(NAME, NBITS, ADDR_W)\
(NBITS <= ADDR_W)?\
NAME[0 +: NBITS]:\
NAME[0 +: ADDR_W]

//gets the n lsbs of address field of cat bus
`define get_naddrbits(NAME, NBITS, ADDR_W, N, I)\
(NBITS <= ADDR_W)?\
NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`DATA_W+`DATA_W/8 +: NBITS]:\
NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`DATA_W+`DATA_W/8 +: ADDR_W]

//gets request section of cat bus using NADDR_W bits in the address
`define get_req_naddrbits(NAME, NBITS, ADDR_W, N, I)\
{`get_valid(NAME, ADDR_W, N, I),\
`get_naddrbits(NAME, NBITS, ADDR_W, N, I),\
`get_wdata(NAME, ADDR_W, N, I),\
`get_wstrb(NAME, ADDR_W, N, I)}

//gets request slice of cat bus
`define get_req_slice(NAME, NBITS, BASE, ADDR_W, N, I)\
{`get_valid(NAME, ADDR_W, N, I),\
NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`BASE +: NBITS]
`get_wdata(NAME, ADDR_W, N, I),\
`get_wstrb(NAME, ADDR_W, N, I)}


////////////////////////////////////////////////////////////////
// CONNECT
//

//connect source cat bus section to destination cat bus section
`define connect_c2c(SRC, SADDR_W, SN, SI, DEST, DADDR_W, DN, DI)\
assign `get_req(DEST, DADDR_W, DN, DI) = `get_req_naddrbits(SRC, DADDR_W, SADDR_W, SN, SI);\
assign `get_resp(SRC, SI) = `get_resp(DEST, DI);

//connect uncat instruction bus to long cat instruction bus
`define connect_u2c(SRC, SADDR_W, DEST, DADDR_W, N, I)\
assign `get_valid(DEST, DADDR_W, N, I)      = SRC`valid;\
assign `get_address(DEST, DADDR_W, N, I)    = `get_nbits(SRC`addr, DADDR_W, SADDR_W);\
assign `get_wdata(DEST, DADDR_W, N, I)      = SRC`wdata;\
assign `get_wstrb(DEST, DADDR_W, N, I)      = SRC`wstrb;\
assign SRC`rdata                            = `get_rdata(DEST, I);\
assign SRC`ready                            = `get_ready(DEST, I);

//connect  long cat instruction bus to uncat instruction bus
`define connect_c2u(SRC, SADDR_W, N, I, DEST, DADDR_W)\
assign DEST`valid                           = `get_valid(SRC, SADDR_W, N, I);\
assign DEST`addr                            = `get_naddrbits(SRC, DADDR_W, SADDR_W, N, I);\
assign DEST`wdata                           = `get_wdata(SRC, SADDR_W, N, I);\
assign DEST`addr                            = `get_wstrb(SRC, SADDR_W, N, I);\
assign `get_rdata(SRC, I)                   = DEST`rdata;\
assign `get_ready(SRC, I)                   = DEST`ready;

//connect uncat instruction buses
`define connect_u2u(SRC, SADDR, DEST, DADDR)\
assign DEST`valid = SRC`valid;\
assign DEST`addr = `get_nbits(DADDR, SADDR, SRC`addr);\
assign DEST`wdata = SRC`wdata;\
assign DEST`wstrb = SRC`wstrb;\
assign SRC`rdata = DEST`rdata;\
assign SRC`ready = DEST`ready;
