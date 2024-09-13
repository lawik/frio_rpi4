DEVTERM_VERSION = 1.0
DEVTERM_SOURCE =

define DEVTERM_INSTALL_TARGET_CMDS
	cp $(NERVES_SYSTEM)/build/linux-custom/arch/arm/boot/dts/overlays/devterm* "$(BINARIES_DIR)/rpi-firmware/overlays/"
	$(INSTALL) -D -m 0644 $(@D)/*.dtbo $(BINARIES_DIR)/rpi-firmware/overlays/
endef

$(eval $(generic-package))
