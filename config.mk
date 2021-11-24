#paths
INTERCON_HW_DIR:=$(INTERCON_DIR)/hardware
INTERCON_INC_DIR:=$(INTERCON_HW_DIR)/include
INTERCON_SRC_DIR:=$(INTERCON_HW_DIR)/src
INTERCON_TB_DIR:=$(INTERCON_HW_DIR)/testbench
INTERCON_SIM_DIR:=$(INTERCON_HW_DIR)/simulation
SUBMODULES_DIR:=$(INTERCON_DIR)/submodules

SIM_DIR ?=$(INTERCON_HW_DIR)/simulation/icarus

# SUBMODULE PATHS
SUBMODULES=
SUBMODULE_DIRS=$(shell ls $(SUBMODULES_DIR))
$(foreach d, $(SUBMODULE_DIRS), $(eval TMP=$(shell make -C $(SUBMODULES_DIR)/$d corename | grep -v make)) $(eval SUBMODULES+=$(TMP)) $(eval $(TMP)_DIR ?=$(SUBMODULES_DIR)/$d))
