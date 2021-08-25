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

// Port

`define AXI4_M_IF_PORT_PREFIX(PREFIX) \
    /*address write*/ \
    output [`AXI_ID_W-1:0]    PREFIX``m_axi_awid,    /*Address write channel ID*/ \
    output [AXI_ADDR_W-1:0]   PREFIX``m_axi_awaddr,  /*Address write channel address*/ \
    output [`AXI_LEN_W-1:0]   PREFIX``m_axi_awlen,   /*Address write channel burst length*/ \
    output [`AXI_SIZE_W-1:0]  PREFIX``m_axi_awsize,  /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    output [`AXI_BURST_W-1:0] PREFIX``m_axi_awburst, /*Address write channel burst type*/ \
    output [`AXI_LOCK_W-1:0]  PREFIX``m_axi_awlock,  /*Address write channel lock type*/ \
    output [`AXI_CACHE_W-1:0] PREFIX``m_axi_awcache, /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    output [`AXI_PROT_W-1:0]  PREFIX``m_axi_awprot,  /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    output [`AXI_QOS_W-1:0]   PREFIX``m_axi_awqos,   /*Address write channel quality of service*/ \
    output                    PREFIX``m_axi_awvalid, /*Address write channel valid*/ \
    input                     PREFIX``m_axi_awready, /*Address write channel ready*/ \
    /*write*/ \
    output [AXI_DATA_W-1:0]   PREFIX``m_axi_wdata,   /*Write channel data*/ \
    output [AXI_DATA_W/8-1:0] PREFIX``m_axi_wstrb,   /*Write channel write strobe*/ \
    output                    PREFIX``m_axi_wlast,   /*Write channel last word flag*/ \
    output                    PREFIX``m_axi_wvalid,  /*Write channel valid*/ \
    input                     PREFIX``m_axi_wready,  /*Write channel ready*/ \
    /*write response*/ \
    input [`AXI_ID_W-1:0]     PREFIX``m_axi_bid,     /*Write response channel ID*/ \
    input [`AXI_RESP_W-1:0]   PREFIX``m_axi_bresp,   /*Write response channel response*/ \
    input                     PREFIX``m_axi_bvalid,  /*Write response channel valid*/ \
    output                    PREFIX``m_axi_bready,  /*Write response channel ready*/ \
    /*address read*/ \
    output [`AXI_ID_W-1:0]    PREFIX``m_axi_arid,    /*Address read channel id*/ \
    output [AXI_ADDR_W-1:0]   PREFIX``m_axi_araddr,  /*Address read channel address*/ \
    output [`AXI_LEN_W-1:0]   PREFIX``m_axi_arlen,   /*Address read channel burst length*/ \
    output [`AXI_SIZE_W-1:0]  PREFIX``m_axi_arsize,  /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    output [`AXI_BURST_W-1:0] PREFIX``m_axi_arburst, /*Address read channel burst type*/ \
    output [`AXI_PROT_W-1:0]  PREFIX``m_axi_arlock,  /*Address read channel lock type*/ \
    output [`AXI_CACHE_W-1:0] PREFIX``m_axi_arcache, /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    output [`AXI_PROT_W-1:0]  PREFIX``m_axi_arprot,  /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    output [`AXI_QOS_W-1:0]   PREFIX``m_axi_arqos,   /*Address read channel quality of service*/ \
    output                    PREFIX``m_axi_arvalid, /*Address read channel valid*/ \
    input                     PREFIX``m_axi_arready, /*Address read channel ready*/ \
    /*read*/ \
    input [`AXI_ID_W-1:0]     PREFIX``m_axi_rid,     /*Read channel ID*/ \
    input [AXI_DATA_W-1:0]    PREFIX``m_axi_rdata,   /*Read channel data*/ \
    input [`AXI_RESP_W-1:0]   PREFIX``m_axi_rresp,   /*Read channel response*/ \
    input                     PREFIX``m_axi_rlast,   /*Read channel last word*/ \
    input                     PREFIX``m_axi_rvalid,  /*Read channel valid*/ \
    output                    PREFIX``m_axi_rready   /*Read channel ready*/

`define AXI4_S_IF_PORT_PREFIX(PREFIX) \
    /*address write*/ \
    input [`AXI_ID_W-1:0]     PREFIX``s_axi_awid,    /*Address write channel ID*/ \
    input [AXI_ADDR_W-1:0]    PREFIX``s_axi_awaddr,  /*Address write channel address*/ \
    input [`AXI_LEN_W-1:0]    PREFIX``s_axi_awlen,   /*Address write channel burst length*/ \
    input [`AXI_SIZE_W-1:0]   PREFIX``s_axi_awsize,  /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    input [`AXI_BURST_W-1:0]  PREFIX``s_axi_awburst, /*Address write channel burst type*/ \
    input [`AXI_LOCK_W-1:0]   PREFIX``s_axi_awlock,  /*Address write channel lock type*/ \
    input [`AXI_CACHE_W-1:0]  PREFIX``s_axi_awcache, /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    input [`AXI_PROT_W-1:0]   PREFIX``s_axi_awprot,  /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    input [`AXI_QOS_W-1:0]    PREFIX``s_axi_awqos,   /*Address write channel quality of service*/ \
    input                     PREFIX``s_axi_awvalid, /*Address write channel valid*/ \
    output                    PREFIX``s_axi_awready, /*Address write channel ready*/ \
    /*write*/ \
    input [AXI_DATA_W-1:0]    PREFIX``s_axi_wdata,   /*Write channel data*/ \
    input [AXI_DATA_W/8-1:0]  PREFIX``s_axi_wstrb,   /*Write channel write strobe*/ \
    input                     PREFIX``s_axi_wlast,   /*Write channel last word flag*/ \
    input                     PREFIX``s_axi_wvalid,  /*Write channel valid*/ \
    output                    PREFIX``s_axi_wready,  /*Write channel ready*/ \
    /*write response*/ \
    output [`AXI_ID_W-1:0]    PREFIX``s_axi_bid,     /*Write response channel ID*/ \
    output [`AXI_RESP_W-1:0]  PREFIX``s_axi_bresp,   /*Write response channel response*/ \
    output                    PREFIX``s_axi_bvalid,  /*Write response channel valid*/ \
    input                     PREFIX``s_axi_bready,  /*Write response channel ready*/ \
    /*address read*/ \
    input [`AXI_ID_W-1:0]     PREFIX``s_axi_arid,    /*Address read channel id*/ \
    input [AXI_ADDR_W-1:0]    PREFIX``s_axi_araddr,  /*Address read channel address*/ \
    input [`AXI_LEN_W-1:0]    PREFIX``s_axi_arlen,   /*Address read channel burst length*/ \
    input [`AXI_SIZE_W-1:0]   PREFIX``s_axi_arsize,  /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    input [`AXI_BURST_W-1:0]  PREFIX``s_axi_arburst, /*Address read channel burst type*/ \
    input [`AXI_PROT_W-1:0]   PREFIX``s_axi_arlock,  /*Address read channel lock type*/ \
    input [`AXI_CACHE_W-1:0]  PREFIX``s_axi_arcache, /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    input [`AXI_PROT_W-1:0]   PREFIX``s_axi_arprot,  /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    input [`AXI_QOS_W-1:0]    PREFIX``s_axi_arqos,   /*Address read channel quality of service*/ \
    input                     PREFIX``s_axi_arvalid, /*Address read channel valid*/ \
    output                    PREFIX``s_axi_arready, /*Address read channel ready*/ \
    /*read*/ \
    output [`AXI_ID_W-1:0]    PREFIX``s_axi_rid,     /*Read channel ID*/ \
    output [AXI_DATA_W-1:0]   PREFIX``s_axi_rdata,   /*Read channel data*/ \
    output [`AXI_RESP_W-1:0]  PREFIX``s_axi_rresp,   /*Read channel response*/ \
    output                    PREFIX``s_axi_rlast,   /*Read channel last word*/ \
    output                    PREFIX``s_axi_rvalid,  /*Read channel valid*/ \
    input                     PREFIX``s_axi_rready   /*Read channel ready*/

`define AXI4_M_IF_PORT_CORE(CORE) \
    `AXI4_M_IF_PORT_PREFIX(CORE``_)

`define AXI4_S_IF_PORT_CORE(CORE) \
    `AXI4_S_IF_PORT_PREFIX(CORE``_)

`define AXI4_M_IF_PORT \
    `AXI4_M_IF_PORT_PREFIX()

`define AXI4_S_IF_PORT \
    `AXI4_S_IF_PORT_PREFIX()
