# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := harfbuzz
$(PKG)_WEBSITE  := https://wiki.freedesktop.org/www/Software/HarfBuzz/
$(PKG)_DESCR    := HarfBuzz is a text shaping engine
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.4.5
$(PKG)_CHECKSUM := 0f052eb4ab01d8bae98ba971c954becb32be57d7250f18af343b1d27892e03fa
$(PKG)_GH_CONF  := harfbuzz/harfbuzz/releases
$(PKG)_SUBDIR   := harfbuzz-$($(PKG)_VERSION)
$(PKG)_FILE     := harfbuzz-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://github.com/harfbuzz/harfbuzz/releases/download/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc freetype-bootstrap glib icu4c cairo

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dcpp_std=c++17 \
        -Dtests=disabled \
        -Ddocs=disabled \
        -Dglib=enabled \
        -Dgobject=enabled \
        -Dcairo=enabled \
        -Dcoretext=enabled \
        -Dfreetype=enabled \
        -Dicu=enabled \
        '$(BUILD_DIR)'
   cd '$(BUILD_DIR)' && ninja
   cd '$(BUILD_DIR)' && ninja install
endef
