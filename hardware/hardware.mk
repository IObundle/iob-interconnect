include $(INTERCON_DIR)/config.mk

#add itself to MODULES list
MODULES+=INTERCON

#paths
INTERCON_HW_DIR:=$(INTERCON_DIR)/hardware
INTERCON_INC_DIR:=$(INTERCON_HW_DIR)/include
INTERCON_SRC_DIR:=$(INTERCON_HW_DIR)/src

#include
INCLUDE+=$(incdir) $(INTERCON_INC_DIR)

#headers
VHDR+=$(INTERCON_INC_DIR)/*.vh $(INTERCON_DIR)/hardware/include/*.v

#sources
VSRC+= $(INTERCON_SRC_DIR)/merge.v $(INTERCON_SRC_DIR)/split.v
