# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := be4ca51
$(PKG)_CHECKSUM := 06890d93d8817d6279e164ad802d32d9286a4b89b52388d0a2e94569f891ad28
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD_STATIC
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    rm -f $(PREFIX)/$(TARGET)/lib/libquazip*.dll*
endef

define $(PKG)_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    mv $(PREFIX)/$(TARGET)/lib/libquazip*.dll $(PREFIX)/$(TARGET)/bin/
    rm -f $(PREFIX)/$(TARGET)/lib/libquazip*.a
endef
