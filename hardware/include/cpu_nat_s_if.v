	       //CPU native interface
               input         valid, //Native CPU interface valid signal
	       input [4:0]   address, //Native CPU interface address signal
               input [31:0]  wdata, //Native CPU interface data write signal
	       input         wstrb, //Native CPU interface write strobe signal
	       output [31:0] rdata, //Native CPU interface read data signal
	       output        ready, //Native CPU interface ready signal
