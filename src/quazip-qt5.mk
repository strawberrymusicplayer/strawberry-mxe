# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt5
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 50ab6b4
$(PKG)_CHECKSUM := d913c14e2c28bd8ca94df7c4810031bb01f69eb747107c0967031f28f90a5766
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qt5base zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
