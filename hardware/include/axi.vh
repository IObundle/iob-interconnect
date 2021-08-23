//
// Signals width
//

// Address width
`define AXI_ADDR_W 32

// 2**1 = 2 AXI IDs
`define AXI_ID_W 1

// 2**8 = 256 max burst length
`define AXI_LEN_W 8

// Burst size width (burst size = 2, 4 bytes per word)
`define AXI_SIZE_W 3

// Burst type width (burst type = 1, Incrementing burst)
`define AXI_BURST_W 2

// Lock Type width (lock type = 0, Normal)
`define AXI_LOCK_W 1

// Memory type width (memory type = 2, Normal, non-cacheable and non-bufferable)
`define AXI_CACHE_W 4

// Protection type width (protection type = 2, Data access, non-secure access and unprivileged access)
`define AXI_PROT_W 3

// Quality of Service width (quality of service = 0, No QoS scheme implemented)
`define AXI_QOS_W 4

// Response width (response = 0 - Okay = 0; Exokay = 1; Slverr = 2; decerr = 3)
`define AXI_RESP_W 2

//
// Signals declaration
//

// Ports

`define AXI4_M_IF_PREFIX(PREFIX) \
    /*address write*/ \
    `OUTPUT(PREFIX``m_axi_awid,    `AXI_ID_W),     /*Address write channel ID*/ \
    `OUTPUT(PREFIX``m_axi_awaddr,   AXI_ADDR_W),   /*Address write channel address*/ \
    `OUTPUT(PREFIX``m_axi_awlen,   `AXI_LEN_W),    /*Address write channel burst length*/ \
    `OUTPUT(PREFIX``m_axi_awsize,  `AXI_SIZE_W),   /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `OUTPUT(PREFIX``m_axi_awburst, `AXI_BURST_W),  /*Address write channel burst type*/ \
    `OUTPUT(PREFIX``m_axi_awlock,  `AXI_LOCK_W),   /*Address write channel lock type*/ \
    `OUTPUT(PREFIX``m_axi_awcache, `AXI_CACHE_W),  /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `OUTPUT(PREFIX``m_axi_awprot,  `AXI_PROT_W),   /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `OUTPUT(PREFIX``m_axi_awqos,   `AXI_QOS_W),    /*Address write channel quality of service*/ \
    `OUTPUT(PREFIX``m_axi_awvalid,  1),            /*Address write channel valid*/ \
    `INPUT(PREFIX``m_axi_awready,   1),            /*Address write channel ready*/ \
    /*write*/ \
    `OUTPUT(PREFIX``m_axi_wdata,    AXI_DATA_W),   /*Write channel data*/ \
    `OUTPUT(PREFIX``m_axi_wstrb,    AXI_DATA_W/8), /*Write channel write strobe*/ \
    `OUTPUT(PREFIX``m_axi_wlast,    1),            /*Write channel last word flag*/ \
    `OUTPUT(PREFIX``m_axi_wvalid,   1),            /*Write channel valid*/ \
    `INPUT(PREFIX``m_axi_wready,    1),            /*Write channel ready*/ \
    /*write response*/ \
    `INPUT(PREFIX``m_axi_bid,      `AXI_ID_W),     /*Write response channel ID*/ \
    `INPUT(PREFIX``m_axi_bresp,    `AXI_RESP_W),   /*Write response channel response*/ \
    `INPUT(PREFIX``m_axi_bvalid,    1),            /*Write response channel valid*/ \
    `OUTPUT(PREFIX``m_axi_bready,   1),            /*Write response channel ready*/ \
    /*address read*/ \
    `OUTPUT(PREFIX``m_axi_arid,    `AXI_ID_W),     /*Address read channel id*/ \
    `OUTPUT(PREFIX``m_axi_araddr,   AXI_ADDR_W),   /*Address read channel address*/ \
    `OUTPUT(PREFIX``m_axi_arlen,   `AXI_LEN_W),    /*Address read channel burst length*/ \
    `OUTPUT(PREFIX``m_axi_arsize,  `AXI_SIZE_W),   /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `OUTPUT(PREFIX``m_axi_arburst, `AXI_BURST_W),  /*Address read channel burst type*/ \
    `OUTPUT(PREFIX``m_axi_arlock,  `AXI_PROT_W),   /*Address read channel lock type*/ \
    `OUTPUT(PREFIX``m_axi_arcache, `AXI_CACHE_W),  /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `OUTPUT(PREFIX``m_axi_arprot,  `AXI_PROT_W),   /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `OUTPUT(PREFIX``m_axi_arqos,   `AXI_QOS_W),    /*Address read channel quality of service*/ \
    `OUTPUT(PREFIX``m_axi_arvalid,  1),            /*Address read channel valid*/ \
    `INPUT(PREFIX``m_axi_arready,   1),            /*Address read channel ready*/ \
    /*read*/ \
    `INPUT(PREFIX``m_axi_rid,      `AXI_ID_W),     /*Read channel ID*/ \
    `INPUT(PREFIX``m_axi_rdata,     AXI_DATA_W),   /*Read channel data*/ \
    `INPUT(PREFIX``m_axi_rresp,    `AXI_RESP_W),   /*Read channel response*/ \
    `INPUT(PREFIX``m_axi_rlast,     1),            /*Read channel last word*/ \
    `INPUT(PREFIX``m_axi_rvalid,    1),            /*Read channel valid*/ \
    `OUTPUT(PREFIX``m_axi_rready,   1)             /*Read channel ready*/

`define AXI4_S_IF_PREFIX(PREFIX) \
    /*address write*/ \
    `INPUT(PREFIX``s_axi_awid,    `AXI_ID_W),     /*Address write channel ID*/ \
    `INPUT(PREFIX``s_axi_awaddr,   AXI_ADDR_W),   /*Address write channel address*/ \
    `INPUT(PREFIX``s_axi_awlen,   `AXI_LEN_W),    /*Address write channel burst length*/ \
    `INPUT(PREFIX``s_axi_awsize,  `AXI_SIZE_W),   /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `INPUT(PREFIX``s_axi_awburst, `AXI_BURST_W),  /*Address write channel burst type*/ \
    `INPUT(PREFIX``s_axi_awlock,  `AXI_LOCK_W),   /*Address write channel lock type*/ \
    `INPUT(PREFIX``s_axi_awcache, `AXI_CACHE_W),  /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `INPUT(PREFIX``s_axi_awprot,  `AXI_PROT_W),   /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `INPUT(PREFIX``s_axi_awqos,   `AXI_QOS_W),    /*Address write channel quality of service*/ \
    `INPUT(PREFIX``s_axi_awvalid,  1),            /*Address write channel valid*/ \
    `OUTPUT(PREFIX``s_axi_awready,   1),          /*Address write channel ready*/ \
    /*write*/ \
    `INPUT(PREFIX``s_axi_wdata,    AXI_DATA_W),   /*Write channel data*/ \
    `INPUT(PREFIX``s_axi_wstrb,    AXI_DATA_W/8), /*Write channel write strobe*/ \
    `INPUT(PREFIX``s_axi_wlast,    1),            /*Write channel last word flag*/ \
    `INPUT(PREFIX``s_axi_wvalid,   1),            /*Write channel valid*/ \
    `OUTPUT(PREFIX``s_axi_wready,    1),          /*Write channel ready*/ \
    /*write response*/ \
    `OUTPUT(PREFIX``s_axi_bid,      `AXI_ID_W),   /*Write response channel ID*/ \
    `OUTPUT(PREFIX``s_axi_bresp,    `AXI_RESP_W), /*Write response channel response*/ \
    `OUTPUT(PREFIX``s_axi_bvalid,    1),          /*Write response channel valid*/ \
    `INPUT(PREFIX``s_axi_bready,   1),            /*Write response channel ready*/ \
    /*address read*/ \
    `INPUT(PREFIX``s_axi_arid,    `AXI_ID_W),     /*Address read channel id*/ \
    `INPUT(PREFIX``s_axi_araddr,   AXI_ADDR_W),   /*Address read channel address*/ \
    `INPUT(PREFIX``s_axi_arlen,   `AXI_LEN_W),    /*Address read channel burst length*/ \
    `INPUT(PREFIX``s_axi_arsize,  `AXI_SIZE_W),   /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `INPUT(PREFIX``s_axi_arburst, `AXI_BURST_W),  /*Address read channel burst type*/ \
    `INPUT(PREFIX``s_axi_arlock,  `AXI_PROT_W),   /*Address read channel lock type*/ \
    `INPUT(PREFIX``s_axi_arcache, `AXI_CACHE_W),  /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `INPUT(PREFIX``s_axi_arprot,  `AXI_PROT_W),   /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `INPUT(PREFIX``s_axi_arqos,   `AXI_QOS_W),    /*Address read channel quality of service*/ \
    `INPUT(PREFIX``s_axi_arvalid,  1),            /*Address read channel valid*/ \
    `OUTPUT(PREFIX``s_axi_arready,   1),          /*Address read channel ready*/ \
    /*read*/ \
    `OUTPUT(PREFIX``s_axi_rid,      `AXI_ID_W),   /*Read channel ID*/ \
    `OUTPUT(PREFIX``s_axi_rdata,     AXI_DATA_W), /*Read channel data*/ \
    `OUTPUT(PREFIX``s_axi_rresp,    `AXI_RESP_W), /*Read channel response*/ \
    `OUTPUT(PREFIX``s_axi_rlast,     1),          /*Read channel last word*/ \
    `OUTPUT(PREFIX``s_axi_rvalid,    1),          /*Read channel valid*/ \
    `INPUT(PREFIX``s_axi_rready,   1)             /*Read channel ready*/

`define AXI4_M_IF_CORE(CORE) \
    `AXI4_M_IF_PREFIX(CORE``_)

`define AXI4_S_IF_CORE(CORE) \
    `AXI4_S_IF_PREFIX(CORE``_)

`define AXI4_M_IF \
    `AXI4_M_IF_PREFIX()

`define AXI4_S_IF \
    `AXI4_S_IF_PREFIX()

// Connections

`define AXI4_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    /*address write*/ \
    .``PREFIX_INT``axi_awid    (PREFIX_EXT``axi_awid),    /*Address write channel ID*/ \
    .``PREFIX_INT``axi_awaddr  (PREFIX_EXT``axi_awaddr),  /*Address write channel address*/ \
    .``PREFIX_INT``axi_awlen   (PREFIX_EXT``axi_awlen),   /*Address write channel burst length*/ \
    .``PREFIX_INT``axi_awsize  (PREFIX_EXT``axi_awsize),  /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    .``PREFIX_INT``axi_awburst (PREFIX_EXT``axi_awburst), /*Address write channel burst type*/ \
    .``PREFIX_INT``axi_awlock  (PREFIX_EXT``axi_awlock),  /*Address write channel lock type*/ \
    .``PREFIX_INT``axi_awcache (PREFIX_EXT``axi_awcache), /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    .``PREFIX_INT``axi_awprot  (PREFIX_EXT``axi_awprot),  /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    .``PREFIX_INT``axi_awqos   (PREFIX_EXT``axi_awqos),   /*Address write channel quality of service*/ \
    .``PREFIX_INT``axi_awvalid (PREFIX_EXT``axi_awvalid), /*Address write channel valid*/ \
    .``PREFIX_INT``axi_awready (PREFIX_EXT``axi_awready), /*Address write channel ready*/ \
    /*write*/ \
    .``PREFIX_INT``axi_wdata   (PREFIX_EXT``axi_wdata),   /*Write channel data*/ \
    .``PREFIX_INT``axi_wstrb   (PREFIX_EXT``axi_wstrb),   /*Write channel write strobe*/ \
    .``PREFIX_INT``axi_wlast   (PREFIX_EXT``axi_wlast),   /*Write channel last word flag*/ \
    .``PREFIX_INT``axi_wvalid  (PREFIX_EXT``axi_wvalid),  /*Write channel valid*/ \
    .``PREFIX_INT``axi_wready  (PREFIX_EXT``axi_wready),  /*Write channel ready*/ \
    /*write response*/ \
    .``PREFIX_INT``axi_bid     (PREFIX_EXT``axi_bid),     /*Write response channel ID*/ \
    .``PREFIX_INT``axi_bresp   (PREFIX_EXT``axi_bresp),   /*Write response channel response*/ \
    .``PREFIX_INT``axi_bvalid  (PREFIX_EXT``axi_bvalid),  /*Write response channel valid*/ \
    .``PREFIX_INT``axi_bready  (PREFIX_EXT``axi_bready),  /*Write response channel ready*/ \
    /*address read*/ \
    .``PREFIX_INT``axi_arid    (PREFIX_EXT``axi_arid),    /*Address read channel id*/ \
    .``PREFIX_INT``axi_araddr  (PREFIX_EXT``axi_araddr),  /*Address read channel address*/ \
    .``PREFIX_INT``axi_arlen   (PREFIX_EXT``axi_arlen),   /*Address read channel burst length*/ \
    .``PREFIX_INT``axi_arsize  (PREFIX_EXT``axi_arsize),  /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    .``PREFIX_INT``axi_arburst (PREFIX_EXT``axi_arburst), /*Address read channel burst type*/ \
    .``PREFIX_INT``axi_arlock  (PREFIX_EXT``axi_arlock),  /*Address read channel lock type*/ \
    .``PREFIX_INT``axi_arcache (PREFIX_EXT``axi_arcache), /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    .``PREFIX_INT``axi_arprot  (PREFIX_EXT``axi_arprot),  /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    .``PREFIX_INT``axi_arqos   (PREFIX_EXT``axi_arqos),   /*Address read channel quality of service*/ \
    .``PREFIX_INT``axi_arvalid (PREFIX_EXT``axi_arvalid), /*Address read channel valid*/ \
    .``PREFIX_INT``axi_arready (PREFIX_EXT``axi_arready), /*Address read channel ready*/ \
    /*read*/ \
    .``PREFIX_INT``axi_rid     (PREFIX_EXT``axi_rid),     /*Read channel ID*/ \
    .``PREFIX_INT``axi_rdata   (PREFIX_EXT``axi_rdata),   /*Read channel data*/ \
    .``PREFIX_INT``axi_rresp   (PREFIX_EXT``axi_rresp),   /*Read channel response*/ \
    .``PREFIX_INT``axi_rlast   (PREFIX_EXT``axi_rlast),   /*Read channel last word*/ \
    .``PREFIX_INT``axi_rvalid  (PREFIX_EXT``axi_rvalid),  /*Read channel valid*/ \
    .``PREFIX_INT``axi_rready  (PREFIX_EXT``axi_rready)   /*Read channel ready*/

`define AXI4_M_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT``m_, PREFIX_EXT``m_)

`define AXI4_S_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT``s_, PREFIX_EXT``s_)

`define AXI4_M2S_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT``m_, PREFIX_EXT``s_)

`define AXI4_S2M_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT``s_, PREFIX_EXT``m_)

`define AXI4_2M_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT``m_)

`define AXI4_2S_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT) \
    `AXI4_IF_CON_PREFIX(PREFIX_INT, PREFIX_EXT``s_)

`define AXI4_M_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_M_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_S_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_S_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_M2S_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_M2S_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_S2M_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_S2M_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_2M_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_2M_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_2S_IF_CON_CORE2CORE(CORE_INT, CORE_EXT) \
    `AXI4_2S_IF_CON_PREFIX(CORE_INT``_, CORE_EXT``_)

`define AXI4_M_IF_CON_CORE(CORE) \
    `AXI4_M_IF_CON_PREFIX(, CORE``_)

`define AXI4_S_IF_CON_CORE(CORE) \
    `AXI4_S_IF_CON_PREFIX(, CORE``_)

`define AXI4_M2S_IF_CON_CORE(CORE) \
    `AXI4_M2S_IF_CON_PREFIX(, CORE``_)

`define AXI4_S2M_IF_CON_CORE(CORE) \
    `AXI4_S2M_IF_CON_PREFIX(, CORE``_)

`define AXI4_2M_IF_CON_CORE(CORE) \
    `AXI4_2M_IF_CON_PREFIX(, CORE``_)

`define AXI4_2S_IF_CON_CORE(CORE) \
    `AXI4_2S_IF_CON_PREFIX(, CORE``_)

`define AXI4_M_IF_CON \
    `AXI4_M_IF_CON_PREFIX(,)

`define AXI4_S_IF_CON \
    `AXI4_S_IF_CON_PREFIX(,)

`define AXI4_M2S_IF_CON \
    `AXI4_M2S_IF_CON_PREFIX(,)

`define AXI4_S2M_IF_CON \
    `AXI4_S2M_IF_CON_PREFIX(,)

`define AXI4_2M_IF_CON \
    `AXI4_2M_IF_CON_PREFIX(,)

`define AXI4_2S_IF_CON \
    `AXI4_2S_IF_CON_PREFIX(,)

// Wires

`define AXI4_IF_W_PREFIX(PREFIX) \
    /*address write*/ \
    `SIGNAL_OUT(PREFIX``axi_awid,    `AXI_ID_W)     /*Address write channel ID*/ \
    `SIGNAL_OUT(PREFIX``axi_awaddr,   AXI_ADDR_W)   /*Address write channel address*/ \
    `SIGNAL_OUT(PREFIX``axi_awlen,   `AXI_LEN_W)    /*Address write channel burst length*/ \
    `SIGNAL_OUT(PREFIX``axi_awsize,  `AXI_SIZE_W)   /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `SIGNAL_OUT(PREFIX``axi_awburst, `AXI_BURST_W)  /*Address write channel burst type*/ \
    `SIGNAL_OUT(PREFIX``axi_awlock,  `AXI_LOCK_W)   /*Address write channel lock type*/ \
    `SIGNAL_OUT(PREFIX``axi_awcache, `AXI_CACHE_W)  /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `SIGNAL_OUT(PREFIX``axi_awprot,  `AXI_PROT_W)   /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `SIGNAL_OUT(PREFIX``axi_awqos,   `AXI_QOS_W)    /*Address write channel quality of service*/ \
    `SIGNAL_OUT(PREFIX``axi_awvalid,  1)            /*Address write channel valid*/ \
    `SIGNAL_OUT(PREFIX``axi_awready,  1)            /*Address write channel ready*/ \
    /*write*/ \
    `SIGNAL_OUT(PREFIX``axi_wdata,    AXI_DATA_W)   /*Write channel data*/ \
    `SIGNAL_OUT(PREFIX``axi_wstrb,    AXI_DATA_W/8) /*Write channel write strobe*/ \
    `SIGNAL_OUT(PREFIX``axi_wlast,    1)            /*Write channel last word flag*/ \
    `SIGNAL_OUT(PREFIX``axi_wvalid,   1)            /*Write channel valid*/ \
    `SIGNAL_OUT(PREFIX``axi_wready,   1)            /*Write channel ready*/ \
    /*write response*/ \
    `SIGNAL_OUT(PREFIX``axi_bid,     `AXI_ID_W)     /*Write response channel ID*/ \
    `SIGNAL_OUT(PREFIX``axi_bresp,   `AXI_RESP_W)   /*Write response channel response*/ \
    `SIGNAL_OUT(PREFIX``axi_bvalid,   1)            /*Write response channel valid*/ \
    `SIGNAL_OUT(PREFIX``axi_bready,   1)            /*Write response channel ready*/ \
    /*address read*/ \
    `SIGNAL_OUT(PREFIX``axi_arid,    `AXI_ID_W)     /*Address read channel id*/ \
    `SIGNAL_OUT(PREFIX``axi_araddr,   AXI_ADDR_W)   /*Address read channel address*/ \
    `SIGNAL_OUT(PREFIX``axi_arlen,   `AXI_LEN_W)    /*Address read channel burst length*/ \
    `SIGNAL_OUT(PREFIX``axi_arsize,  `AXI_SIZE_W)   /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    `SIGNAL_OUT(PREFIX``axi_arburst, `AXI_BURST_W)  /*Address read channel burst type*/ \
    `SIGNAL_OUT(PREFIX``axi_arlock,  `AXI_PROT_W)   /*Address read channel lock type*/ \
    `SIGNAL_OUT(PREFIX``axi_arcache, `AXI_CACHE_W)  /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    `SIGNAL_OUT(PREFIX``axi_arprot,  `AXI_PROT_W)   /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    `SIGNAL_OUT(PREFIX``axi_arqos,   `AXI_QOS_W)    /*Address read channel quality of service*/ \
    `SIGNAL_OUT(PREFIX``axi_arvalid,  1)            /*Address read channel valid*/ \
    `SIGNAL_OUT(PREFIX``axi_arready,  1)            /*Address read channel ready*/ \
    /*read*/ \
    `SIGNAL_OUT(PREFIX``axi_rid,     `AXI_ID_W)     /*Read channel ID*/ \
    `SIGNAL_OUT(PREFIX``axi_rdata,    AXI_DATA_W)   /*Read channel data*/ \
    `SIGNAL_OUT(PREFIX``axi_rresp,   `AXI_RESP_W)   /*Read channel response*/ \
    `SIGNAL_OUT(PREFIX``axi_rlast,    1)            /*Read channel last word*/ \
    `SIGNAL_OUT(PREFIX``axi_rvalid,   1)            /*Read channel valid*/ \
    `SIGNAL_OUT(PREFIX``axi_rready,   1)            /*Read channel ready*/

`define AXI4_M_IF_W_PREFIX(PREFIX) \
    `AXI4_IF_W_PREFIX(PREFIX``m_)

`define AXI4_S_IF_W_PREFIX(PREFIX) \
    `AXI4_IF_W_PREFIX(PREFIX``s_)

`define AXI4_M_IF_W_CORE(CORE) \
    `AXI4_M_IF_W_PREFIX(CORE``_)

`define AXI4_S_IF_W_CORE(CORE) \
    `AXI4_S_IF_W_PREFIX(CORE``_)

`define AXI4_M_IF_W \
    `AXI4_M_IF_W_PREFIX()

`define AXI4_S_IF_W \
    `AXI4_S_IF_W_PREFIX()
