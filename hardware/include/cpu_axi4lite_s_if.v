   //address write
   input [0:0]             m_axi_awid, //Address write channel ID
   input [31:0]            m_axi_awaddr,//Address write channel address
   input [0:0]             m_axi_awlock,//Address write channel lock type
   input [3:0]             m_axi_awcache,//Address write channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   input [2:0]             m_axi_awprot,//Address write channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   input                   m_axi_awvalid,//Address write channel valid
   output                    m_axi_awready,//Address write channel ready

   //write
   input [31:0]            m_axi_wdata,//Write channel data
   input [3:0]             m_axi_wstrb,//Write channel write strobe
   input                   m_axi_wlast,//Write channel last word flag
   input                   m_axi_wvalid,//Write channel valid
   output                    m_axi_wready,//Write channel ready

   //write response
   output [0:0]              m_axi_bid,//Write response channel ID
   output [1:0]              m_axi_bresp,//Write response channel response
   output                    m_axi_bvalid,//Write response channel valid
   input                   m_axi_bready,//Write response channel ready
  
   //address read
   input [0:0]             m_axi_arid,//Address read channel id
   input [31:0]            m_axi_araddr,//Address read channel address
   input [0:0]             m_axi_arlock,//Address read channel lock type
   input [3:0]             m_axi_arcache,//Address read channel memory type. Transactions set with Normal Non-cacheable Modifiable and Bufferable (0011).
   input [2:0]             m_axi_arprot,//Address read channel protection type. Transactions set with Normal, Secure, and Data attributes (000).
   input                   m_axi_arvalid,//Address read channel valid
   output                    m_axi_arready,//Address read channel ready

   //read
   output [0:0]              m_axi_rid,//Read channel ID
   output [31:0]             m_axi_rdata,//Read channel data
   output [1:0]              m_axi_rresp,//Read channel response
   output                    m_axi_rlast,//Read channel last word
   output                    m_axi_rvalid,//Read channel valid
   input                   m_axi_rready,//Read channel ready 
