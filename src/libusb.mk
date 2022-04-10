# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libusb
$(PKG)_WEBSITE  := https://libusb.info/
$(PKG)_DESCR    := A cross-platform user library to access USB devices
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.26
$(PKG)_CHECKSUM := a09bff99c74e03e582aa30759cada218ea8fa03580517e52d463c59c0b25e240
$(PKG)_GH_CONF  := libusb/libusb/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
