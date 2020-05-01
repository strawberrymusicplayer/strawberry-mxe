# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 13348ef
$(PKG)_CHECKSUM := e47fac135f63633c0257c2ee820c91ac617b1f1f2ef6522899d610ad48ad054f
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD_STATIC
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    rm -f $(PREFIX)/$(TARGET)/lib/libQt5Quazip*.dll
endef

define $(PKG)_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    #mv $(PREFIX)/$(TARGET)/lib/libQt5Quazip*.dll $(PREFIX)/$(TARGET)/bin/
    rm -f $(PREFIX)/$(TARGET)/lib/libQt5Quazip*.a
endef
