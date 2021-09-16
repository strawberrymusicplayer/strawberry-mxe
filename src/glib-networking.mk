# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := glib-networking
$(PKG)_WEBSITE  := https://www.gnome.org
$(PKG)_DESCR    := Network-related GIO modules for glib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.70.0
$(PKG)_CHECKSUM := 66b408e7afa86c582fe38963db56133869ab4b57d34e48ec56aba621940d6f35
$(PKG)_SUBDIR   := glib-networking-$($(PKG)_VERSION)
$(PKG)_FILE     := glib-networking-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf glib gnutls openssl

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/glib-networking) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    grep -v 'alpha' |
    grep -v 'beta' |
    grep -v '\.rc' |
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson -Dgnutls=enabled -Dopenssl=enabled '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
