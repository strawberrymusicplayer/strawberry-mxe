# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := chromaprint
$(PKG)_WEBSITE  := https://acoustid.org/chromaprint
$(PKG)_DESCR    := Chromaprint
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.2
$(PKG)_CHECKSUM := d54ada62c16b2db396d3251ec54fc7a58909c163131a1cfcf7fa6407dbc14360
$(PKG)_GH_CONF  := acoustid/chromaprint/releases/latest, v
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc ffmpeg

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DBUILD_TESTS=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
