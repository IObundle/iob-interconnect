INTERCON_DIR:=.
include config.mk

corename:
	@echo "INTERCON"

sim:
	make -C $(SIM_DIR)

sim-clean:
	make -C $(SIM_DIR) clean

.PHONY: corename sim sim-clean
