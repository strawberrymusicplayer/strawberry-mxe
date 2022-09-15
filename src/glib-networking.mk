# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := glib-networking
$(PKG)_WEBSITE  := https://gitlab.gnome.org/GNOME/glib-networking
$(PKG)_DESCR    := Network extensions for GLib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.74.0
$(PKG)_CHECKSUM := 1f185aaef094123f8e25d8fa55661b3fd71020163a0174adb35a37685cda613b
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
