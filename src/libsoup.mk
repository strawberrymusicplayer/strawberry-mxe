# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.67.1
$(PKG)_CHECKSUM := d155cd3f2dab8d5dbae2ac928369c9930d289211dcd92a447f6dac29b4f0475f
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson ninja glib libxml2 sqlite brotli libpsl

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/libsoup/-/tags' | \
#    $(SED) -n "s,.*libsoup-\([0-9]\+\.[0-9]*[02468]*\.[^']*\)\.tar.*,\1,p" | \
#    $(SORT) -Vr | \
#    head -1
#endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(PREFIX)/x86_64-pc-linux-gnu/bin/meson \
                                --cross-file '$(PREFIX)/$(TARGET)/share/meson/mxe-crossfile.meson' \
                                --prefix='$(PREFIX)/$(TARGET)' \
                                --buildtype=release \
                                --pkg-config-path='$(PREFIX)/$(TARGET)/bin/pkgconf' \
                                -Dtests=false \
                                -Dvapi=false \
                                -Dgssapi=false \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
