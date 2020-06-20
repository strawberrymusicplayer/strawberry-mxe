# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libusb
$(PKG)_WEBSITE  := https://github.com/libusb/libusb
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.23
$(PKG)_CHECKSUM := 02620708c4eea7e736240a623b0b156650c39bfa93a14bcfa5f3e05270313eba
$(PKG)_GH_CONF  := libusb/libusb/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --without-cython
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
