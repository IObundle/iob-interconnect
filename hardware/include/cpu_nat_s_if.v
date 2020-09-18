	       //CPU native interface
               `INPUT(valid,   1),  //Native CPU interface valid signal
	       `INPUT(address, 6),  //Native CPU interface address signal
               `INPUT(wdata,   32), //Native CPU interface data write signal
	       `INPUT(wstrb,   1),  //Native CPU interface write strobe signal
	       `OUTPUT(rdata,  32), //Native CPU interface read data signal
	       `OUTPUT(ready,  1),  //Native CPU interface ready signal
