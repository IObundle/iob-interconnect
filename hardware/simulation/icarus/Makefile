# simulation frequency
FREQ := 100000000

# file paths
RTL_DIR := ../..
SUBMODULES_DIR := ../../../submodules
AXI_RAM_DIR := $(SUBMODULES_DIR)/axi-mem

# hw includes
HW_INCLUDE := -I$(RTL_DIR)/include

# testbench defines
TB_DEFINE = -DCLK_FREQ=$(FREQ)
TB_DEFINE += -DVCD

# icarus verilog simulator
VLOG := iverilog -Wall -g2005-sv

# hardware sources
VHDR = $(RTL_DIR)/include/*.vh
VSRC = \
$(RTL_DIR)/src/iob2axi.v \
$(AXI_RAM_DIR)/rtl/axil_ram.v

all: iob2axi

iob2axi: $(RTL_DIR)/testbench/iob2axi_tb.v $(VSRC) $(VHDR)
	$(VLOG) $(HW_INCLUDE) $(TB_DEFINE) -o $@ $< $(VSRC)
	./$@

clean:
	@rm -f *# *~ *.vcd iob2axi

.PHONY: all clean
