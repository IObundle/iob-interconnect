//
// INTERCONNECT MACROS
//

//uncomment to parse independently


//`define DATA_W 32

//BUS TYPES
`define I 0
`define D 1

//TODO: insert type argument in macros after name 

//CONCAT BUS WIDTHS
//request part
`define BUS_REQ_W(TYPE, ADDR_W) 1+ADDR_W+TYPE*(`DATA_W+`DATA_W/8)
//response part
`define BUS_RESP_W              `DATA_W+1
//whole
`define BUS_W(TYPE, ADDR_W)     `BUS_REQ_W(TYPE, ADDR_W)+`BUS_RESP_W

//UNCAT BUS SUFFIXES
//signals
`define valid _valid
`define addr  _addr
`define wdata _wdata
`define wstrb _wstrb
`define rdata _rdata
`define ready _ready
//type instruction, data or resized
`define i     _i
`define d     _d
`define r     _r



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


////////////////////////////////////////////////////////////////
// CONNECT
//

`define connect_c2c(TYPE, SRC, DEST, ADDR_W, N, I)\
assign `get_req(TYPE, DEST,  ADDR_W, N, I) = `get_req(TYPE, SRC, ADDR_W, 1);\
assign `get_resp(SRC, N, I) = `get_resp(TYPE, DEST,  ADDR_W, N);

`define connect_u2c_master(TYPE, UNCAT, CAT, ADDR_W, N, I)\
assign CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1]                    = UNCAT`valid;\
assign CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1 -: ADDR_W]          = UNCAT`addr;\
assign CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1-ADDR_W -: `DATA_W]  = UNCAT`wdata;\
assign CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDRW)-1-ADDR_W -: `DATA_W/8] = UNCAT`wstrb;\
assign UNCAT`rdata                                                            = CAT[I*`BUS_RESP_W+`DATA_W -: `DATA_W];\
assign UNCAT`ready                                                            = CAT[I*`BUS_RESP_W];

`define connect_u2c_slave(TYPE, UNCAT, CAT, ADDR_W, N, I)\
assign UNCAT`valid                           = CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1];\
assign UNCAT`addr                            = CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-2 -: ADDR_W];\
assign UNCAT`wdata                           = CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-2-ADDR_W -: `DATA_W];\
assign UNCAT`wstrb                           = CAT[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-2-ADDR_W-`DATA_W -: `DATA_W/8];\
assign CAT[I*`BUS_RESP_W+`DATA_W -: `DATA_W] = UNCAT`rdata;\ 
assign CAT[I*`BUS_RESP_W]                    = UNCAT`ready;

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
//GET REQ AND RESP

//gets the request part of bus
//whole
`define get_req (TYPE, NAME, ADDR_W, N)\
NAME[N*`BUS_W(TYPE, ADDR_W)-1 -: N*`BUS_REQ_W(TYPE, ADDR_W)] 
//slice
`define get_req (TYPE, NAME, ADDR_W, N, I)\
NAME[N*`BUS_RESP_W+(I+1)*`BUS_REQ_W(TYPE, ADDR_W)-1 -: `BUS_REQ_W(TYPE, ADDR_W)] 

//gets the response part of bus
//whole
`define get_resp(NAME, N) NAME[N*`BUS_RESP_W-1 -: 0]
//slice
`define get_resp(NAME, N, I) NAME[(I+1)*`BUS_RESP_W-1 -: `BUS_RESP_W]

//gets the valid bit of bus
`define get_valid(TYPE, NAME, ADDR_W, I) NAME[(I+1)*`BUS_REQ_W(TYPE, NAME, ADDR_W)-1]

//gets the address field of bus
`define get_address(TYPE, NAME, ADDR_W, I) NAME[(I+1)*`BUS_REQ_W(TYPE, NAME, ADDR_W)-2 -: ADDR_W]


///////////////////////////////////////////////////////////////////////////////////
// TRANSFORM

//convert instruction to data bus
`define i2d(SRC, DEST, ADDR_W)\
wire [`BUS_W(`D, ADDR_W)-1:0] DEST;\ //declare widened bus
//valid & addr
assign DEST[`BUS_W(`D, ADDR_W)-1 -: ADDR_W+1] = SRC[`BUS_W(`I, ADDR_W)-1];\
//wdata & wstrb
assign DEST[`BUS_W(`D, ADDR_W)-2 - ADDR_W -: `DATA_W+`DATA_W/8] = {`DATA_W+`DATA_W/8{1'b0}};\
//rdata & ready
assign SRC[`DATA_W : 0] = DEST[`DATA_W : 0];


//convert bus to wider bus to macth addr_w
`define widen (TYPE, SRC, SRC_ADDR_W, DEST, DEST_ADDR_W)\
wire [`BUS_W(TYPE, DEST_ADDR_W)-1:0] DEST;\ //declare widened bus
//valid 
assign DEST[`BUS_W(TYPE, DEST_ADDR_W)-1] = SRC[`BUS_W(TYPE, SRC_ADDR_W)-1];\
//addr
assign DEST[`BUS_W(TYPE, DEST_ADDR_W)-2 -: DEST_ADDR_W] = 
       {`BUS_W(TYPE, DEST_ADDR_W)-`BUS_W(TYPE, SRC_ADDR_W){1'b0}}, SRC[`BUS_W(TYPE, SRC_ADDR_W)-2 -: SRC_ADDR_W]};\
//wdata & wstrb
assign DEST[`BUS_W(TYPE, DEST_ADDR_W)-2 - DEST_ADDR_W -: `DATA_W+`DATA_W/8] = DEST[`BUS_W(TYPE, SRC_ADDR_W)-2 - SRC_ADDR_W -: `DATA_W+`DATA_W/8];\
//rdata & ready
assign SRC[`DATA_W : 0] = DEST[`DATA_W : 0];
