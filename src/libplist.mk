# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libplist
$(PKG)_WEBSITE  := https://github.com/libimobiledevice/libplist
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.2.0
$(PKG)_CHECKSUM := 7e654bdd5d8b96f03240227ed09057377f06ebad08e1c37d0cfa2abe6ba0cee2
$(PKG)_GH_CONF  := libimobiledevice/libplist/tags
$(PKG)_DEPS     := cc libxml2

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true $(SHELL) ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --without-cython
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
