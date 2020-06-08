# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ab9b50f
$(PKG)_CHECKSUM := 22bf72fdef4c3e21b4ff27882f520b02977ce5ddb4a8e3e71b6e50d07896a2d5
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD_STATIC
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define $(PKG)_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
