# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libplist
$(PKG)_WEBSITE  := https://github.com/libimobiledevice/libplist
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.0
$(PKG)_CHECKSUM := 4b33f9af3f9208d54a3c3e1a8c149932513f451c98d1dd696fe42c06e30b7f03
$(PKG)_GH_CONF  := libimobiledevice/libplist/tags
$(PKG)_DEPS     := cc libxml2

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --without-cython
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
