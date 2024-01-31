# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libusb
$(PKG)_WEBSITE  := https://libusb.info/
$(PKG)_DESCR    := A cross-platform user library to access USB devices
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.27
$(PKG)_CHECKSUM := e8f18a7a36ecbb11fb820bd71540350d8f61bcd9db0d2e8c18a6fb80b214a3de
$(PKG)_GH_CONF  := libusb/libusb/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
