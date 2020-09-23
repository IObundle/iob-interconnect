   //address write
   `INPUT(s_axil_awaddr,   ADDR_W), //Address write channel address
   `INPUT(s_axil_awcache,  4),  //Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `INPUT(s_axil_awprot,   3),  //Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `INPUT(s_axil_awvalid,  1),  //Address write channel valid
   `OUTPUT(s_axil_awready, 1),  //Address write channel ready

   //write
   `INPUT(s_axil_wdata,   DATA_W), //Write channel data
   `INPUT(s_axil_wstrb,   DATA_W/8),  //Write channel write strobe
   `INPUT(s_axil_wvalid,  1),  //Write channel valid
   `OUTPUT(s_axil_wready, 1),  //Write channel ready

   //write response
   `OUTPUT(s_axil_bresp,  2), //Write response channel response
   `OUTPUT(s_axil_bvalid, 1), //Write response channel valid
   `INPUT(s_axil_bready,  1), //Write response channel ready
  
   //address read
   `INPUT(s_axil_araddr,   ADDR_W), //Address read channel address
   `INPUT(s_axil_arcache,  4),  //Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `INPUT(s_axil_arprot,   3),  //Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `INPUT(s_axil_arvalid,  1),  //Address read channel valid
   `OUTPUT(s_axil_arready, 1),  //Address read channel ready

   //read
   `OUTPUT(s_axil_rdata,  DATA_W), //Read channel data
   `OUTPUT(s_axil_rresp,  2),  //Read channel response
   `OUTPUT(s_axil_rvalid, 1),  //Read channel valid
   `INPUT(s_axil_rready,  1),  //Read channel ready 
