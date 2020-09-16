   //address write
   `INPUT(m_axi_awid,     1),  //Address write channel ID
   `INPUT(m_axi_awaddr,   32), //Address write channel address
   `INPUT(m_axi_awlock,   1),  //Address write channel lock type
   `INPUT(m_axi_awcache,  4),  //Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `INPUT(m_axi_awprot,   3),  //Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `INPUT(m_axi_awvalid,  1),  //Address write channel valid
   `OUTPUT(m_axi_awready, 1),  //Address write channel ready

   //write
   `INPUT(m_axi_wdata,   32), //Write channel data
   `INPUT(m_axi_wstrb,   4),  //Write channel write strobe
   `INPUT(m_axi_wlast,   1),  //Write channel last word flag
   `INPUT(m_axi_wvalid,  1),  //Write channel valid
   `OUTPUT(m_axi_wready, 1),  //Write channel ready

   //write response
   `OUTPUT(m_axi_bid,    1), //Write response channel ID
   `OUTPUT(m_axi_bresp,  2), //Write response channel response
   `OUTPUT(m_axi_bvalid, 1), //Write response channel valid
   `INPUT(m_axi_bready,  1), //Write response channel ready
  
   //address read
   `INPUT(m_axi_arid,     1),  //Address read channel id
   `INPUT(m_axi_araddr,   32), //Address read channel address
   `INPUT(m_axi_arlock,   1),  //Address read channel lock type
   `INPUT(m_axi_arcache,  4),  //Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   `INPUT(m_axi_arprot,   3),  //Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   `INPUT(m_axi_arvalid,  1),  //Address read channel valid
   `OUTPUT(m_axi_arready, 1),  //Address read channel ready

   //read
   `OUTPUT(m_axi_rid,    1),  //Read channel ID
   `OUTPUT(m_axi_rdata,  32), //Read channel data
   `OUTPUT(m_axi_rresp,  2),  //Read channel response
   `OUTPUT(m_axi_rlast,  1),  //Read channel last word
   `OUTPUT(m_axi_rvalid, 1),  //Read channel valid
   `INPUT(m_axi_rready,  1),  //Read channel ready 
