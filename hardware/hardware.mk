include $(INTERCON_DIR)/config.mk

#add itself to MODULES list
MODULES+=INTERCON

#include
INCLUDE+=$(incdir)$(INTERCON_INC_DIR)

#headers
VHDR+=$(INTERCON_INC_DIR)/*.vh $(INTERCON_INC_DIR)/*.v

#sources
VSRC+= $(INTERCON_SRC_DIR)/merge.v $(INTERCON_SRC_DIR)/split.v
