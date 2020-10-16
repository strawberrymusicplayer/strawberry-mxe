# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3bbe624
$(PKG)_CHECKSUM := 3e8cbef34354171c6f4ba8e34ea81fb64e52c632de61b9ccfb93a3bc364b71d9
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
