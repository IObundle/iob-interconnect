# simulation frequency
FREQ:=100000000

include $(INTERCON_DIR)/hardware/hardware.mk

# hw includes
INCLUDE:=-I$(INTERCON_INC_DIR)

# testbench defines
DEFINE=$(defmacro)CLK_FREQ=$(FREQ)
DEFINE+=$(defmacro)VCD

# hardware sources
VHDR=$(INTERCON_INC_DIR)/*.vh
VSRC= \
$(INTERCON_SRC_DIR)/iob2axi.v \
$(AXIMEM_DIR)/rtl/axil_ram.v

# testbench
VSRC+=$(INTERCON_TB_DIR)/iob2axi_tb.v
