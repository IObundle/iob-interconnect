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

`define AXI4_M_IF_PORTS_PREFIX(PREFIX) \
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

`define AXI4_S_IF_PORTS_PREFIX(PREFIX) \
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
    input                     PREFIX``s_axi_rready,  /*Read channel ready*/

`define AXI4_M_IF_PORTS_CORE(CORE) \
    `AXI4_M_IF_PORTS_PREFIX(CORE``_)

`define AXI4_S_IF_PORTS_CORE(CORE) \
    `AXI4_S_IF_PORTS_PREFIX(CORE``_)

`define AXI4_M_IF_PORTS \
    `AXI4_M_IF_PORTS_PREFIX()

`define AXI4_S_IF_PORTS \
    `AXI4_S_IF_PORTS_PREFIX()

// Connections

`define AXI4_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    /*address write*/ \
    .``PORTS_PREFIX``axi_awid    (WIRES_PREFIX``axi_awid),    /*Address write channel ID*/ \
    .``PORTS_PREFIX``axi_awaddr  (WIRES_PREFIX``axi_awaddr),  /*Address write channel address*/ \
    .``PORTS_PREFIX``axi_awlen   (WIRES_PREFIX``axi_awlen),   /*Address write channel burst length*/ \
    .``PORTS_PREFIX``axi_awsize  (WIRES_PREFIX``axi_awsize),  /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    .``PORTS_PREFIX``axi_awburst (WIRES_PREFIX``axi_awburst), /*Address write channel burst type*/ \
    .``PORTS_PREFIX``axi_awlock  (WIRES_PREFIX``axi_awlock),  /*Address write channel lock type*/ \
    .``PORTS_PREFIX``axi_awcache (WIRES_PREFIX``axi_awcache), /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    .``PORTS_PREFIX``axi_awprot  (WIRES_PREFIX``axi_awprot),  /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    .``PORTS_PREFIX``axi_awqos   (WIRES_PREFIX``axi_awqos),   /*Address write channel quality of service*/ \
    .``PORTS_PREFIX``axi_awvalid (WIRES_PREFIX``axi_awvalid), /*Address write channel valid*/ \
    .``PORTS_PREFIX``axi_awready (WIRES_PREFIX``axi_awready), /*Address write channel ready*/ \
    /*write*/ \
    .``PORTS_PREFIX``axi_wdata   (WIRES_PREFIX``axi_wdata),   /*Write channel data*/ \
    .``PORTS_PREFIX``axi_wstrb   (WIRES_PREFIX``axi_wstrb),   /*Write channel write strobe*/ \
    .``PORTS_PREFIX``axi_wlast   (WIRES_PREFIX``axi_wlast),   /*Write channel last word flag*/ \
    .``PORTS_PREFIX``axi_wvalid  (WIRES_PREFIX``axi_wvalid),  /*Write channel valid*/ \
    .``PORTS_PREFIX``axi_wready  (WIRES_PREFIX``axi_wready),  /*Write channel ready*/ \
    /*write response*/ \
    .``PORTS_PREFIX``axi_bid     (WIRES_PREFIX``axi_bid),     /*Write response channel ID*/ \
    .``PORTS_PREFIX``axi_bresp   (WIRES_PREFIX``axi_bresp),   /*Write response channel response*/ \
    .``PORTS_PREFIX``axi_bvalid  (WIRES_PREFIX``axi_bvalid),  /*Write response channel valid*/ \
    .``PORTS_PREFIX``axi_bready  (WIRES_PREFIX``axi_bready),  /*Write response channel ready*/ \
    /*address read*/ \
    .``PORTS_PREFIX``axi_arid    (WIRES_PREFIX``axi_arid),    /*Address read channel id*/ \
    .``PORTS_PREFIX``axi_araddr  (WIRES_PREFIX``axi_araddr),  /*Address read channel address*/ \
    .``PORTS_PREFIX``axi_arlen   (WIRES_PREFIX``axi_arlen),   /*Address read channel burst length*/ \
    .``PORTS_PREFIX``axi_arsize  (WIRES_PREFIX``axi_arsize),  /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    .``PORTS_PREFIX``axi_arburst (WIRES_PREFIX``axi_arburst), /*Address read channel burst type*/ \
    .``PORTS_PREFIX``axi_arlock  (WIRES_PREFIX``axi_arlock),  /*Address read channel lock type*/ \
    .``PORTS_PREFIX``axi_arcache (WIRES_PREFIX``axi_arcache), /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    .``PORTS_PREFIX``axi_arprot  (WIRES_PREFIX``axi_arprot),  /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    .``PORTS_PREFIX``axi_arqos   (WIRES_PREFIX``axi_arqos),   /*Address read channel quality of service*/ \
    .``PORTS_PREFIX``axi_arvalid (WIRES_PREFIX``axi_arvalid), /*Address read channel valid*/ \
    .``PORTS_PREFIX``axi_arready (WIRES_PREFIX``axi_arready), /*Address read channel ready*/ \
    /*read*/ \
    .``PORTS_PREFIX``axi_rid     (WIRES_PREFIX``axi_rid),     /*Read channel ID*/ \
    .``PORTS_PREFIX``axi_rdata   (WIRES_PREFIX``axi_rdata),   /*Read channel data*/ \
    .``PORTS_PREFIX``axi_rresp   (WIRES_PREFIX``axi_rresp),   /*Read channel response*/ \
    .``PORTS_PREFIX``axi_rlast   (WIRES_PREFIX``axi_rlast),   /*Read channel last word*/ \
    .``PORTS_PREFIX``axi_rvalid  (WIRES_PREFIX``axi_rvalid),  /*Read channel valid*/ \
    .``PORTS_PREFIX``axi_rready  (WIRES_PREFIX``axi_rready)   /*Read channel ready*/

`define AXI4_M_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX``m_, WIRES_PREFIX``m_)

`define AXI4_S_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX``s_, WIRES_PREFIX``s_)

`define AXI4_M2S_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX``m_, WIRES_PREFIX``s_)

`define AXI4_S2M_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX``s_, WIRES_PREFIX``m_)

`define AXI4_2M_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX``m_)

`define AXI4_2S_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX) \
    `AXI4_IF_CON_PREFIX(PORTS_PREFIX, WIRES_PREFIX``s_)

`define AXI4_M_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_M_IF_CON_PREFIX(INST_CORE``_, CORE``_)

`define AXI4_S_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_S_IF_CON_PREFIX(INST_CORE``_, CORE``_)

`define AXI4_M2S_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_M2S_IF_CON_PREFIX(INST_CORE``_, CORE``_)

`define AXI4_S2M_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_S2M_IF_CON_PREFIX(INST_CORE``_, CORE``_)

`define AXI4_2M_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_2M_IF_CON_PREFIX(INST_CORE``_, CORE``_)

`define AXI4_2S_IF_CON_INST_CORE2CORE(INST_CORE, CORE) \
    `AXI4_2S_IF_CON_PREFIX(INST_CORE``_, CORE``_)

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

`define AXI4_IF_WIRES_PREFIX(PREFIX) \
    /*address write*/ \
    wire [`AXI_ID_W-1:0]    PREFIX``axi_awid;    /*Address write channel ID*/ \
    wire [AXI_ADDR_W-1:0]   PREFIX``axi_awaddr;  /*Address write channel address*/ \
    wire [`AXI_LEN_W-1:0]   PREFIX``axi_awlen;   /*Address write channel burst length*/ \
    wire [`AXI_SIZE_W-1:0]  PREFIX``axi_awsize;  /*Address write channel burst size. This signal indicates the size of each transfer in the burst*/ \
    wire [`AXI_BURST_W-1:0] PREFIX``axi_awburst; /*Address write channel burst type*/ \
    wire [`AXI_LOCK_W-1:0]  PREFIX``axi_awlock;  /*Address write channel lock type*/ \
    wire [`AXI_CACHE_W-1:0] PREFIX``axi_awcache; /*Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    wire [`AXI_PROT_W-1:0]  PREFIX``axi_awprot;  /*Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    wire [`AXI_QOS_W-1:0]   PREFIX``axi_awqos;   /*Address write channel quality of service*/ \
    wire                    PREFIX``axi_awvalid; /*Address write channel valid*/ \
    wire                    PREFIX``axi_awready; /*Address write channel ready*/ \
    /*write*/ \
    wire [AXI_DATA_W-1:0]   PREFIX``axi_wdata;   /*Write channel data*/ \
    wire [AXI_DATA_W/8-1:0] PREFIX``axi_wstrb;   /*Write channel write strobe*/ \
    wire                    PREFIX``axi_wlast;   /*Write channel last word flag*/ \
    wire                    PREFIX``axi_wvalid;  /*Write channel valid*/ \
    wire                    PREFIX``axi_wready;  /*Write channel ready*/ \
    /*write response*/ \
    wire [`AXI_ID_W-1:0]    PREFIX``axi_bid;     /*Write response channel ID*/ \
    wire [`AXI_RESP_W-1:0]  PREFIX``axi_bresp;   /*Write response channel response*/ \
    wire                    PREFIX``axi_bvalid;  /*Write response channel valid*/ \
    wire                    PREFIX``axi_bready;  /*Write response channel ready*/ \
    /*address read*/ \
    wire [`AXI_ID_W-1:0]    PREFIX``axi_arid;    /*Address read channel id*/ \
    wire [AXI_ADDR_W-1:0]   PREFIX``axi_araddr;  /*Address read channel address*/ \
    wire [`AXI_LEN_W-1:0]   PREFIX``axi_arlen;   /*Address read channel burst length*/ \
    wire [`AXI_SIZE_W-1:0]  PREFIX``axi_arsize;  /*Address read channel burst size. This signal indicates the size of each transfer in the burst*/ \
    wire [`AXI_BURST_W-1:0] PREFIX``axi_arburst; /*Address read channel burst type*/ \
    wire [`AXI_PROT_W-1:0]  PREFIX``axi_arlock;  /*Address read channel lock type*/ \
    wire [`AXI_CACHE_W-1:0] PREFIX``axi_arcache; /*Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).*/ \
    wire [`AXI_PROT_W-1:0]  PREFIX``axi_arprot;  /*Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).*/ \
    wire [`AXI_QOS_W-1:0]   PREFIX``axi_arqos;   /*Address read channel quality of service*/ \
    wire                    PREFIX``axi_arvalid; /*Address read channel valid*/ \
    wire                    PREFIX``axi_arready; /*Address read channel ready*/ \
    /*read*/ \
    wire [`AXI_ID_W-1:0]    PREFIX``axi_rid;     /*Read channel ID*/ \
    wire [AXI_DATA_W-1:0]   PREFIX``axi_rdata;   /*Read channel data*/ \
    wire [`AXI_RESP_W-1:0]  PREFIX``axi_rresp;   /*Read channel response*/ \
    wire                    PREFIX``axi_rlast;   /*Read channel last word*/ \
    wire                    PREFIX``axi_rvalid;  /*Read channel valid*/ \
    wire                    PREFIX``axi_rready   /*Read channel ready*/

`define AXI4_M_IF_WIRES_PREFIX(PREFIX) \
    `AXI4_IF_WIRES_PREFIX(PREFIX``m_)

`define AXI4_S_IF_WIRES_PREFIX(PREFIX) \
    `AXI4_IF_WIRES_PREFIX(PREFIX``s_)

`define AXI4_M_IF_WIRES_CORE(CORE) \
    `AXI4_M_IF_WIRES_PREFIX(CORE``_)

`define AXI4_S_IF_WIRES_CORE(CORE) \
    `AXI4_S_IF_WIRES_PREFIX(CORE``_)

`define AXI4_M_IF_WIRES \
    `AXI4_M_IF_WIRES_PREFIX()

`define AXI4_S_IF_WIRES \
    `AXI4_S_IF_WIRES_PREFIX()
