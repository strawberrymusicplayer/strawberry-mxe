# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0d1aedb
$(PKG)_CHECKSUM := 20e6a7c22783f0b23898602520b63448aef0336260b055e969b2432c6aa8b502
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qt5base zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
