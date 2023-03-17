# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := glib-networking
$(PKG)_WEBSITE  := https://gitlab.gnome.org/GNOME/glib-networking
$(PKG)_DESCR    := Network extensions for GLib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.76.0
$(PKG)_CHECKSUM := 149a05a179e629a538be25662aa324b499d7c4549c5151db5373e780a1bf1b9a
$(PKG)_SUBDIR   := glib-networking-$($(PKG)_VERSION)
$(PKG)_FILE     := glib-networking-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf glib gnutls openssl

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/glib-networking/tags' | \
    $(SED) -n "s,.*glib-networking-\([0-9]\+\.[0-9]*[0-9]*\.[^']*\)\.tar.*,\1,p" |
    grep -v 'alpha' |
    grep -v 'beta' |
    grep -v '\.rc' |
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Dgnutls=enabled -Dopenssl=enabled -Dinstalled_tests=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
