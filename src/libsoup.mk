# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.6.4
$(PKG)_CHECKSUM := 9b54c76f5276b05bebcaf2b6c2a141a188fc7bb1d0624eda259dac13a6665c8a
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib glib-networking sqlite brotli libpsl nghttp2 $(BUILD)~ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/libsoup/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[02468]\.[0-9]\+\)<.*,\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && CFLAGS='-Wno-nonnull' LDFLAGS='$(LDFLAGS) -Wl,--allow-multiple-definition' '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dtests=false \
        -Dvapi=disabled \
        -Dgssapi=disabled \
        -Dintrospection=disabled \
        -Dtests=false \
        -Dsysprof=disabled \
        -Dtls_check=false \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
