//
// BUS INTERCONNECT MACROS
//

//DATA WIDTHS
`define VALID_W 1
`define WSTRB_W DATA_W/8
`define READY_W 1

`define WRITE_W (DATA_W+`WSTRB_W)
`define READ_W (DATA_W+`READY_W)

//DATA POSITIONS
//req bus 
`define WDATA_P `WSTRB_W
`define ADDR_P  (`WDATA_P+DATA_W)
`define VALID_P (`ADDR_P+ADDR_W)
//resp bus
`define RDATA_P `READY_W
              
//CONCAT BUS WIDTHS
//request part
`define REQ_W (`VALID_W+ADDR_W+`WRITE_W)
//response part
`define RESP_W (`READ_W)

/////////////////////////////////////////////////////////////////////////////////
//FIELD RANGES

//gets request section of cat bus
`define req(I) I*`REQ_W +: `REQ_W

//gets the response part of a cat bus section
`define resp(I) I*`RESP_W +: `RESP_W

//gets the valid bit of cat bus section 
`define valid(I) I*`REQ_W + `VALID_P

//gets the address of cat bus section
`define address(I,W) I*`REQ_W+`ADDR_P+W-1 -: W

//gets the wdata field of cat bus
`define wdata(I) I*`REQ_W+`WDATA_P +: DATA_W

//gets the wstrb field of cat bus
`define wstrb(I) I*`REQ_W +: `WSTRB_W

//gets the write fields of cat bus
`define write(I) I*`REQ_W +: `WRITE_W

//gets the rdata field of cat bus
`define rdata(I) I*`RESP_W+`RDATA_P +: DATA_W

//gets the ready field of cat bus
`define ready(I) I*`RESP_W

