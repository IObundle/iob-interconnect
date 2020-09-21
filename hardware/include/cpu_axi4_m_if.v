   //address write
   `OUTPUT(m_axi_awid,    1),  //Address write channel ID
   `OUTPUT(m_axi_awaddr,  AXI_ADDR_W), //Address write channel address
   `OUTPUT(m_axi_awlen,   8),  //Address write channel burst length
   `OUTPUT(m_axi_awsize,  3),  //Address write channel burst size. This signal indicates the size of each transfer in the burst
   `OUTPUT(m_axi_awburst, 2),  //Address write channel burst type
   `OUTPUT(m_axi_awlock,  1),  //Address write channel lock type
   `OUTPUT(m_axi_awcache, 4),  //Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `OUTPUT(m_axi_awprot,  3),  //Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `OUTPUT(m_axi_awqos,   4),  //Address write channel quality of service
   `OUTPUT(m_axi_awvalid, 1),  //Address write channel valid
   `INPUT(m_axi_awready,  1),  //Address write channel ready

   //write
   `OUTPUT(m_axi_wdata,   AXI_DATA_W), //Write channel data
   `OUTPUT(m_axi_wstrb,   AXI_DATA_W/8),  //Write channel write strobe
   `OUTPUT(m_axi_wlast,   1),  //Write channel last word flag
   `OUTPUT(m_axi_wvalid,  1),  //Write channel valid
   `INPUT(m_axi_wready,   1),  //Write channel ready

   //write response
   `INPUT(m_axi_bid,      1),  //Write response channel ID
   `INPUT(m_axi_bresp,    2),  //Write response channel response
   `INPUT(m_axi_bvalid,   1),  //Write response channel valid
   `OUTPUT(m_axi_bready,  1),  //Write response channel ready
  
   //address read
   `OUTPUT(m_axi_arid,    1),  //Address read channel id
   `OUTPUT(m_axi_araddr,  AXI_ADDR_W), //Address read channel address
   `OUTPUT(m_axi_arlen,   8),  //Address read channel burst length
   `OUTPUT(m_axi_arsize,  3),  //Address read channel burst size. This signal indicates the size of each transfer in the burst
   `OUTPUT(m_axi_arburst, 2),  //Address read channel burst type
   `OUTPUT(m_axi_arlock,  1),  //Address read channel lock type
   `OUTPUT(m_axi_arcache, 4),  //Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `OUTPUT(m_axi_arprot,  3),  //Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `OUTPUT(m_axi_arqos,   4),  //Address read channel quality of service
   `OUTPUT(m_axi_arvalid, 1),  //Address read channel valid
   `INPUT(m_axi_arready,  1),  //Address read channel ready

   //read
   `INPUT(m_axi_rid,      1),  //Read channel ID
   `INPUT(m_axi_rdata,    AXI_DATA_W), //Read channel data
   `INPUT(m_axi_rresp,    2),  //Read channel response
   `INPUT(m_axi_rlast,    1),  //Read channel last word
   `INPUT(m_axi_rvalid,   1),  //Read channel valid
   `OUTPUT(m_axi_rready,  1),  //Read channel ready 
