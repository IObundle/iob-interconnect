//
// INTERCONNECT MACROS
//

//uncomment to parse independently
`define DATA_W 32

//BUS TYPES
`define I 0
`define D 1

//CONCAT BUS WIDTHS
//request part
`define BUS_REQ_W(TYPE, ADDR_W) (1+ADDR_W+TYPE*(`DATA_W+`DATA_W/8))
//response part
`define BUS_RESP_W              (`DATA_W+1)
//whole
`define BUS_W(TYPE, ADDR_W)     `BUS_REQ_W(TYPE, ADDR_W)+`BUS_RESP_W

//UNCAT BUS SUFFIXES
`define valid _valid
`define addr  _addr
`define wdata _wdata
`define wstrb _wstrb
`define rdata _rdata
`define ready _ready


///////////////////////////////////////////////////////////////////
//DECLARE
//

//IBUS
`define bus_cat(TYPE, NAME, ADDR_W, N) wire [N*`BUS_W(TYPE, ADDR_W)-1:0] NAME;

`define ibus_uncat(NAME, ADDR_W)\
wire  NAME`valid;\
wire [ADDR_W-1:0] NAME`addr;\
wire [`DATA_W-1:0] NAME`rdata;\
wire NAME`ready;

`define dbus_uncat(NAME, ADDR_W)\
wire  NAME`valid;\
wire [ADDR_W-1:0] NAME`addr;\
wire [`DATA_W-1:0] NAME`wdata;\
wire [`DATA_W/8-1:0] NAME`wstrb;\
wire [`DATA_W-1:0] NAME`rdata;\
wire NAME`ready;


///////////////////////////////////////////////////////////////////////////////////
//GET FIELDS

//gets the valid bit of cat bus
`define get_valid(TYPE, NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W + (I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1]

//gets the address field of cat bus
`define get_address(TYPE, NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-2 -: ADDR_W]

//gets the address field of cat bus
`define get_valid_address(TYPE, NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1 -: 1+ADDR_W]

//gets the wdata field of cat bus
`define get_wdata(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(`D, ADDR_W)-2-ADDR_W -: `DATA_W]

//gets the wstrb field of cat bus
`define get_wstrb(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(`D, ADDR_W)-2-ADDR_W-`DATA_W -: `DATA_W/8]

//gets the write fields of cat bus
`define get_write(NAME, ADDR_W, N, I) NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(`D, ADDR_W)-2-ADDR_W -: `DATA_W+`DATA_W/8]

//gets the request part of cat bus
`define get_req(TYPE, NAME, ADDR_W, N, I)\
NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1 -: `BUS_REQ_W(TYPE, ADDR_W)]

//gets all the request part of cat bus
`define get_req_all(TYPE, NAME, ADDR_W, N)\
NAME[N*`BUS_W(TYPE, ADDR_W)-1 -: N*`BUS_REQ_W(TYPE, ADDR_W)]

//gets the rdata field of cat bus
`define get_rdata(NAME, I) NAME[(I+1)*`BUS_RESP_W-1 -: `DATA_W]

//gets the ready field of cat bus
`define get_ready(NAME, I) NAME[I*`BUS_RESP_W]

//gets the response part of a cat bus
`define get_resp(NAME, I) NAME[(I+1)*`BUS_RESP_W-1 -: `BUS_RESP_W]

//gets all the response part of a cat bus
`define get_resp_all(NAME, N) NAME[N*`BUS_RESP_W-1 : 0]

////////////////////////////////////////////////////////////////
// CONNECT
//

`define connect_c2cc(TYPE, SRC, DEST, ADDR_W, N, I)\
assign `get_req(TYPE, DEST,  ADDR_W, N, I) = `get_req(TYPE, SRC, ADDR_W, 1, 0);\
assign `get_resp(SRC, 0) = `get_resp(DEST, I);

//need to use 0 and not `I because of precedence of argument replacement
`define connect_u2cc_i(UNCAT, CAT, ADDR_W, N, I)\
assign `get_valid(0, CAT, ADDR_W, N, I)     = UNCAT`valid;\
assign `get_address(0, CAT, ADDR_W, N, I)   = UNCAT`addr;\
assign UNCAT`rdata                           = `get_rdata(CAT, I);\
assign UNCAT`ready                           = `get_ready(CAT, I);

`define connect_cc2u_i(CAT, UNCAT, ADDR_W, N, I)\
assign UNCAT`valid                           = `get_valid(0, CAT, ADDR_W, N, I);\
assign UNCAT`addr                            = `get_address(0, CAT, ADDR_W, N, I);\
assign `get_rdata(CAT, I)                    = UNCAT`rdata;\
assign `get_ready(CAT, I)                    = UNCAT`ready;

//assign UNCAT`valid = CAT[N*`BUS_RESP_W + (I+1)*`BUS_REQ_W(`I, ADDR_W)-1];\


`define connect_u2cc_d(UNCAT, CAT, ADDR_W, N, I)\
assign `get_valid(`D, CAT, ADDR_W, N, I)     = UNCAT`valid;\
assign `get_address(`D, CAT, ADDR_W, N, I)   = UNCAT`addr;\
assign `get_wdata(CAT, ADDR_W, N, I)         = UNCAT`wdata;\
assign `get_wstrb(CAT, ADDR_W, N, I)         = UNCAT`wstrb;\
assign UNCAT`rdata                           = `get_rdata(CAT, I);\
assign UNCAT`ready                           = `get_ready(CAT, I);

`define connect_cc2u_d(CAT, UNCAT, ADDR_W, N, I)\
assign UNCAT`valid                           = `get_valid(`D, CAT, ADDR_W, N, I);\
assign UNCAT`addr                            = `get_address(`D, CAT, ADDR_W, N, I);\
assign UNCAT`wdata                           = `get_wdata(CAT, ADDR_W, N, I);\
assign UNCAT`addr                            = `get_wstrb(CAT, ADDR_W, N, I);\
assign `get_rdata(CAT, I)                    = UNCAT`rdata;\
assign `get_ready(CAT, I)                    = UNCAT`ready;

`define connect_u2u_d(SRC, DEST, ADDR_W, N, I)\
assign DEST`valid = SRC`valid;\
assign DEST`addr = SRC`addr;\
assign DEST`wdata = SRC`wdata;\
assign DEST`wstrb = SRC`wstrb;\
assign SRC`rdata = DEST`rdata;\
assign SRC`ready = DEST`ready;

`define connect_u2u_i(SRC, DEST, ADDR_W, N, I)\
assign DEST`valid = SRC`valid;\
assign DEST`addr = SRC`addr;\
assign SRC`rdata = DEST`rdata;\
assign SRC`ready = DEST`ready;


///////////////////////////////////////////////////////////////////////////////////
// TRANSFORM

//convert instruction cat bus to data cat bus
`define i2d(SRC, DEST, ADDR_W)\
assign `get_valid_address(`D, DEST, ADDR_W, 1, 0) = `get_valid_address(`I, SRC, ADDR_W, 1, 0);\
assign `get_write(`D, DEST, ADDR_W, 1, 0) = {`DATA_W+`DATA_W/8{1'b0}};\
assign `get_resp(SRC, 0) = `get_resp(DEST, 0);

//widen address field of bus to match destination
`define widen (TYPE, SRC, SRC_ADDR_W, DEST, DEST_ADDR_W)\
assign `get_valid_address(TYPE, DEST, ADDR_W, 1, 0) = `get_valid_address(TYPE, SRC, ADDR_W, 1, 0);\
assign `get_write(TYPE, DEST, ADDR_W, 1, 0) = {`DATA_W+`DATA_W/8{1'b0}};\
assign `get_resp(SRC, 0) = `get_resp(DEST, 0);
