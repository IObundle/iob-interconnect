INTERCON_DIR:=.
include config.mk

corename:
	@echo $(MODULE)

sim:
	make -C $(SIM_DIR)

clean:
	make -C $(SIM_DIR) clean

.PHONY: corename sim clean
