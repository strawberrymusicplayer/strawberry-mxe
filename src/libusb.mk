# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libusb
$(PKG)_WEBSITE  := https://libusb.info/
$(PKG)_DESCR    := A cross-platform user library to access USB devices
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.25
$(PKG)_CHECKSUM := f9c4b7dad27a6196ca9ec3c6ec7fa446194342de326c71e030eb2c480895e169
$(PKG)_GH_CONF  := libusb/libusb/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
