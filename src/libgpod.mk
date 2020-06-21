# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgpod
$(PKG)_WEBSITE  := https://github.com/libgpod/libgpod
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.8.3
$(PKG)_CHECKSUM := 638a7959d04e95f1e62abad02bd33702e4e8dfef98485ac7d9d50395c37e955d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/gtkpod/libgpod/$(PKG)-0.8/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib libplist

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) needs to be written.' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && aclocal
    cd '$(SOURCE_DIR)' && autoconf
    cd '$(SOURCE_DIR)' && automake
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
