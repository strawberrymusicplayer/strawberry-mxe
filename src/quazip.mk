# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 67090b3
$(PKG)_CHECKSUM := a6b13ed3218ff19b854a7e6dc31012c860cc84ad6ebac3b4f43af885f453ad17
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
