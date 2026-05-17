# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libusb
$(PKG)_WEBSITE  := https://libusb.info/
$(PKG)_DESCR    := A cross-platform user library to access USB devices
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.30
$(PKG)_CHECKSUM := 2ae28adb0bb9558c86135c4e1c11b320b0805461e207a64a6e520a114094bf07
$(PKG)_GH_CONF  := libusb/libusb/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
