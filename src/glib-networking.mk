# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := glib-networking
$(PKG)_WEBSITE  := https://www.gnome.org
$(PKG)_DESCR    := Network-related GIO modules for glib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.64.0
$(PKG)_CHECKSUM := 5cda27d45447160261d4bb77fc2f9766fc8b07dbd471ba2336a5fcb38521a1ba
$(PKG)_SUBDIR   := glib-networking-$($(PKG)_VERSION)
$(PKG)_FILE     := glib-networking-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf ninja glib gnutls openssl

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/glib-networking) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson -Dgnutls=enabled -Dopenssl=enabled '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
