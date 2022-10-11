# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.2.1
$(PKG)_CHECKSUM := b1eb3d2c3be49fbbd051a71f6532c9626bcecea69783190690cd7e4dfdf28f29
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
    cd '$(SOURCE_DIR)' && LDFLAGS='$(LDFLAGS) -Wl,--allow-multiple-definition' '$(TARGET)-meson' \
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
