INTERCON_HW_DIR:=$(INTERCON_DIR)/hardware

#include
INTERCON_INC_DIR:=$(INTERCON_HW_DIR)/include
INCLUDE+=$(incdir) $(INTERCON_INC_DIR)

#headers
VHDR+=$(wildcard $(INTERCON_INC_DIR)/*.vh)

#sources
INTERCON_SRC_DIR:=$(INTERCON_HW_DIR)/src
VSRC+= $(INTERCON_SRC_DIR)/merge.v $(INTERCON_SRC_DIR)/split.v
