   //address write
   output [0:0]             m_axi_awid, //Address write channel ID
   output [31:0]            m_axi_awaddr,//Address write channel address
   output [7:0]             m_axi_awlen,//Address write channel burst length
   output [2:0]             m_axi_awsize,//Address write channel burst size. This signal indicates the size of each transfer in the burst
   output [1:0]             m_axi_awburst,//Address write channel burst type
   output [0:0]             m_axi_awlock,//Address write channel lock type
   output [3:0]             m_axi_awcache,//Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   output [2:0]             m_axi_awprot,//Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   output [3:0]             m_axi_awqos,//Address write channel quality of service
   output                   m_axi_awvalid,//Address write channel valid
   input                    m_axi_awready,//Address write channel ready

   //write
   output [31:0]            m_axi_wdata,//Write channel data
   output [3:0]             m_axi_wstrb,//Write channel write strobe
   output                   m_axi_wlast,//Write channel last word flag
   output                   m_axi_wvalid,//Write channel valid
   input                    m_axi_wready,//Write channel ready

   //write response
   input [0:0]              m_axi_bid,//Write response channel ID
   input [1:0]              m_axi_bresp,//Write response channel response
   input                    m_axi_bvalid,//Write response channel valid
   output                   m_axi_bready,//Write response channel ready
  
   //address read
   output [0:0]             m_axi_arid,//Address read channel id
   output [31:0]            m_axi_araddr,//Address read channel address
   output [7:0]             m_axi_arlen,//Address read channel burst length
   output [2:0]             m_axi_arsize,//Address read channel burst size. This signal indicates the size of each transfer in the burst
   output [1:0]             m_axi_arburst,//Address read channel burst type
   output [0:0]             m_axi_arlock,//Address read channel lock type
   output [3:0]             m_axi_arcache,//Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   output [2:0]             m_axi_arprot,//Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   output [3:0]             m_axi_arqos,//Address read channel quality of service
   output                   m_axi_arvalid,//Address read channel valid
   input                    m_axi_arready,//Address read channel ready

   //read
   input [0:0]              m_axi_rid,//Read channel ID
   input [31:0]             m_axi_rdata,//Read channel data
   input [1:0]              m_axi_rresp,//Read channel response
   input                    m_axi_rlast,//Read channel last word
   input                    m_axi_rvalid,//Read channel valid
   output                   m_axi_rready,//Read channel ready 
