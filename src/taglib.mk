# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib Audio Meta-Data Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.13.1
$(PKG)_CHECKSUM := c8da2b10f1bfec2cd7dbfcd33f4a2338db0765d851a50583d410bacf055cfd0b
$(PKG)_GH_CONF  := taglib/taglib/releases/latest, v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
