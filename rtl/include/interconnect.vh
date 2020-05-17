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

//gets the request part of cat bus
`define get_req(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W) +: `BUS_REQ_W(ADDR_W)]

//gets the response part of a cat bus
`define get_resp(NAME, I) NAME[I*`BUS_RESP_W +: `BUS_RESP_W]

//gets the valid bit of cat bus
`define get_valid(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W + (I+1)*`BUS_REQ_W(ADDR_W)-1]

//gets the address field of cat bus
`define get_address(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(ADDR_W)-2 -: ADDR_W]

//gets the address field of cat bus
`define get_narrow_address(NAME, ADDR_W, ADDRN_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(ADDR_W)+`DATA_W+`DATA_W/8 +: ADDRN_W]

//gets the address field of cat bus
`define get_valid_address(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(ADDR_W)-1 -: 1+ADDR_W]

//gets the wdata field of cat bus
`define get_wdata(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(`D, ADDR_W)+`DATA_W/8 +: `DATA_W]

//gets the wstrb field of cat bus
`define get_wstrb(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(`D, ADDR_W) +: `DATA_W/8]

//gets the write fields of cat bus
`define get_write(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+I*`BUS_REQ_W(`D, ADDR_W) +: `DATA_W+`DATA_W/8]

//gets the rdata field of cat bus
`define get_rdata(NAME, I) NAME[I*`BUS_RESP_W +: `DATA_W]

//gets the ready field of cat bus
`define get_ready(NAME, I) NAME[I*`BUS_RESP_W]



////////////////////////////////////////////////////////////////
// CONNECT
//

//connect single cat bus to section of long cata bus
`define connect_c2lc(SRC, DEST, ADDR_W, N, I)\
assign `get_req(DEST,  ADDR_W, N, I) = `get_req(SRC, ADDR_W, 1, 0);\
assign `get_resp(SRC, 0) = `get_resp(DEST, I);

//connect section of long cata bus to single cat bus
`define connect_lc2c(SRC, DEST, ADDR_W, N, I)\
assign `get_req(DEST, ADDR_W, 1, 0) = `get_req(SRC,  ADDR_W, N, I);\ 
assign `get_resp(SRC, I) = `get_resp(DEST, 0);

//connect uncat instruction bus to long cat instruction bus
`define connect_u2lc(UNCAT, CAT, ADDR_W, N, I)\
assign `get_valid(CAT, ADDR_W, N, I)     = UNCAT`valid;\
assign `get_address(CAT, ADDR_W, N, I)   = UNCAT`addr;\
assign `get_wdata(CAT, ADDR_W, N, I)         = UNCAT`wdata;\
assign `get_wstrb(CAT, ADDR_W, N, I)         = UNCAT`wstrb;\
assign UNCAT`rdata                           = `get_rdata(CAT, I);\
assign UNCAT`ready                           = `get_ready(CAT, I);

//connect  long cat instruction bus to uncat instruction bus
`define connect_lc2u(CAT, UNCAT, ADDR_W, N, I)\
assign UNCAT`valid                           = `get_valid(CAT, ADDR_W, N, I);\
assign UNCAT`addr                            = `get_address(CAT, ADDR_W, N, I);\
assign UNCAT`wdata                           = `get_wdata(CAT, ADDR_W, N, I);\
assign UNCAT`addr                            = `get_wstrb(CAT, ADDR_W, N, I);\
assign `get_rdata(CAT, I)                    = UNCAT`rdata;\
assign `get_ready(CAT, I)                    = UNCAT`ready;

//connect uncat instruction buses
`define connect_u2u(SRC, DEST)\
assign DEST`valid = SRC`valid;\
assign DEST`addr = SRC`addr;\
assign DEST`wdata = SRC`wdata;\
assign DEST`wstrb = SRC`wstrb;\
assign SRC`rdata = DEST`rdata;\
assign SRC`ready = DEST`ready;
