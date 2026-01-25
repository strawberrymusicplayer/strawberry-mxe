# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libwebp
$(PKG)_WEBSITE  := https://developers.google.com/speed/webp/
$(PKG)_DESCR    := WebP is a modern image format that provides superior lossless and lossy compression for images on the web
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.0
$(PKG)_CHECKSUM := e4ab7009bf0629fd11982d4c2aa83964cf244cffba7347ecd39019a9e38c4564
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://storage.googleapis.com/downloads.webmproject.org/releases/webp/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html' | \
    $(SED) -n 's,.*libwebp-\([0-9]\+\.[0-9]\+\.[0-9]\+\)\.tar.gz.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DWEBP_LINK_STATIC=$(CMAKE_STATIC_BOOL) \
        -DWEBP_UNICODE=ON \
        -DWEBP_USE_THREAD=ON
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
