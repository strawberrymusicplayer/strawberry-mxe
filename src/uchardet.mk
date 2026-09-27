# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := uchardet
$(PKG)_WEBSITE  := https://www.freedesktop.org/wiki/Software/uchardet/
$(PKG)_DESCR    := An encoding detector library ported from Mozilla
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.0.8
$(PKG)_CHECKSUM := e97a60cfc00a1c147a674b097bb1422abd9fa78a2d9ce3f3fdcc2e78a34ac5f0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://www.freedesktop.org/software/uchardet/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.freedesktop.org/software/uchardet/releases/' | \
    $(SED) -n "s,.*uchardet-\([0-9]*\.[0-9]*\.[0-9]*\)\.tar\.xz.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC=OFF \
        -DBUILD_BINARY=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
