#path
INTERCON_HW_DIR:=$(INTERCON_DIR)/hardware

#include
INTERCON_INC_DIR:=$(INTERCON_HW_DIR)/include
INCLUDE+=$(incdir) $(INTERCON_INC_DIR)

#headers
VHDR+=$(INTERCON_INC_DIR)/*.vh $(INTERCON_DIR)/hardware/include/*.v

#sources
INTERCON_SRC_DIR:=$(INTERCON_HW_DIR)/src
VSRC+= $(INTERCON_SRC_DIR)/merge.v $(INTERCON_SRC_DIR)/split.v
