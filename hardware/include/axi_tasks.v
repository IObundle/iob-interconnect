//
// Tasks for the AXI-4 protocol
//

// Write data to AXI-4 lite slave
task write_data_axil;
   input [AXIL_ADDR_W-1:0]       axilAddress;
   input [AXIL_DATA_W-1:0]       axilData;

   begin
      #1;

      // Write address
      s_axil_awaddr = (axilAddress*4);
      s_axil_awvalid = 1'b1;

      while (!s_axil_awready) begin
         @ (posedge clk) #1;
      end
      s_axil_awvalid = 1'b0;

      // Write data
      s_axil_wdata = axilData;
      s_axil_wvalid = 1'b1;

      while (!s_axil_wready) begin
         @ (posedge clk) #1;
      end
      s_axil_wvalid = 1'b0;

      // Write response
      if (!s_axil_bvalid) begin
         @ (posedge clk) #1;
      end
      s_axil_bready = 1'b1;

      @ (posedge clk) #1;
      s_axil_bready = 1'b0;

      @ (posedge clk);
   end
endtask

// Read data from AXI-4 lite slave
task read_data_axil;
   input [AXIL_ADDR_W-1:0]      axilAddress;
   output reg [AXIL_DATA_W-1:0] axilData;

   begin
      #1;

      // Write address
      s_axil_araddr = (axilAddress*4);
      s_axil_arvalid = 1'b1;

      if (!s_axil_arready) begin
         @ (posedge clk) #1;
      end
      s_axil_arvalid = 1'b0;

      // Read data
      while (!s_axil_rvalid) begin
         @ (posedge clk) #1;
      end
      s_axil_rready = 1'b1;

      axilData = s_axil_rdata;

      @ (posedge clk) #1;

      s_axil_rready = 1'b0;

      @ (posedge clk);
   end
endtask
