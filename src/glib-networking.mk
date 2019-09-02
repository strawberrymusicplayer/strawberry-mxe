# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := glib-networking
$(PKG)_WEBSITE  := https://www.gnome.org
$(PKG)_DESCR    := Network-related GIO modules for glib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.61.1
$(PKG)_CHECKSUM := a3acbe8953ba80e408bdc4a3e8c240fd9447181c7e800a175c3105604c38bad5
$(PKG)_SUBDIR   := glib-networking-$($(PKG)_VERSION)
$(PKG)_FILE     := glib-networking-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson ninja glib gnutls

define $(PKG)_UPDATE
   $(WGET) -q -O- 'https://git.gnome.org/browse/glib-networking/refs/tags' | \
    grep '<a href=' | \
    $(SED) -n 's,.*<a[^>]*>\([0-9]*\.[0-9]*[02468]\.[^<]*\)<.*,\1,p' | \
    sort -Vr | \
    head -1
endef

define $(PKG)_BUILD_NATIVE
    cd '$(SOURCE_DIR)' && $(PREFIX)/x86_64-pc-linux-gnu/bin/meson \
                                --prefix='$(PREFIX)/$(TARGET)' \
                                --buildtype=release \
                                --pkg-config-path='$(PREFIX)/$(TARGET)/bin/pkgconf' \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(PREFIX)/x86_64-pc-linux-gnu/bin/meson \
                                --cross-file='$(PREFIX)/$(TARGET)/share/meson/mxe-crossfile.meson' \
                                --prefix='$(PREFIX)/$(TARGET)' \
                                --buildtype=release \
                                --pkg-config-path='$(PREFIX)/$(TARGET)/bin/pkgconf' \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
