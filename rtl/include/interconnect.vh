//
// BUS INTERCONNECT MACROS
//

//uncomment to parse independently
//`define ADDR_W 32
//`define DATA_W 32

//DATA WIDTHS
`define VALIDW 1
`define WSTRBW `DATA_W/8
`define READYW 1

`define WRITEW (`DATA_W+`WSTRBW)
`define READW (`DATA_W+`READYW)

//DATA POSITIONS
//req bus 
`define WDATAP `WSTRBW
`define ADDRP  (`WDATAP+`DATA_W)
`define VALIDP (`ADDRP+`ADDR_W)
//resp bus
`define RDATAP `READYW
              
//CONCAT BUS WIDTHS
//request part
`define REQ_W (`VALIDW+`ADDR_W+`WRITEW)
//response part
`define RESP_W (`READW)

/////////////////////////////////////////////////////////////////////////////////
//FIELD RANGES

//gets request section of cat bus
`define req(I) I*`REQ_W +: `REQ_W

//gets the response part of a cat bus section
`define resp(I) I*`RESP_W +: `RESP_W

//gets the valid bit of cat bus section 
`define valid(I) I*`REQ_W + `VALIDP

//gets the address of cat bus section
`define address(I) I*`REQ_W+`ADDRP +: `ADDR_W

//gets the address of cat bus section
`define address_section(I, MSB, NBITS) I*`REQ_W+`ADDRP+MSB -: NBITS

//gets the wdata field of cat bus
`define wdata(I) I*`REQ_W+`WDATAP +: `DATA_W

//gets the wstrb field of cat bus
`define wstrb(I) I*`REQ_W +: `WSTRBW

//gets the write fields of cat bus
`define write(I) I*`REQ_W +: `WRITEW

//gets the rdata field of cat bus
`define rdata(I) I*`RESP_W+`RDATAP +: `DATA_W

//gets the ready field of cat bus
`define ready(I) I*`RESP_W

