# file paths
INTERCON_DIR:=../../..

defmacro:=-D
incdir:=-I

SIMULATOR=icarus

include ../simulation.mk

# icarus verilog simulator
VLOG:=iverilog -Wall -g2005-sv $(INCLUDE) $(DEFINE)

all: iob2axi

iob2axi: $(VSRC) $(VHDR)
	$(VLOG) -o $@ $(VSRC)
	./$@

clean:
	@rm -f *# *~ *.vcd iob2axi

.PHONY: all clean
