# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.68.2
$(PKG)_CHECKSUM := 51ad3001a946fe3bcf29b692dc9ffe05cdf702ea6ca0ee8c3099a99a2f4e3933
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson ninja glib glib-networking libxml2 sqlite brotli libpsl

define $(PKG)_UPDATE
    $(WGET) -q -O- -t 2 --timeout=6 'https://gitlab.gnome.org/GNOME/libsoup/-/tags' | \
    $(SED) -n "s,.*libsoup-\([0-9]\+\.[0-9]*[02468]*\.[^']*\)\.tar.*,\1,p" | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(PREFIX)/x86_64-pc-linux-gnu/bin/meson \
                                --cross-file '$(PREFIX)/$(TARGET)/share/meson/mxe-crossfile.meson' \
                                --prefix='$(PREFIX)/$(TARGET)' \
                                --buildtype=release \
                                --pkg-config-path='$(PREFIX)/$(TARGET)/bin/pkgconf' \
                                -Dtests=false \
                                -Dvapi=disabled \
                                -Dgssapi=disabled \
                                -Dintrospection=disabled \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
