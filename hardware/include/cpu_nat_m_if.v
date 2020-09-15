      output                clk,
      output                rst,
      output                valid,
      output [ADDR_W-1:9]   addr,
      output [DATA_W-1:0]   wdata,      
      output [DATA_W/8-1:0] wstrb,
      input [DATA_W-1:0]    rdata,
      input                 ready
