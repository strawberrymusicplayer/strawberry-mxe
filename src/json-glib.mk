# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := json-glib
$(PKG)_WEBSITE  := https://gitlab.gnome.org/GNOME/json-glib
$(PKG)_DESCR    := JSON-GLib implements a full JSON parser and generator using GLib and GObject, and integrates JSON with GLib data types.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.6
$(PKG)_CHECKSUM := 96ec98be7a91f6dde33636720e3da2ff6ecbb90e76ccaa49497f31a6855a490e
$(PKG)_SUBDIR   := json-glib-$($(PKG)_VERSION)
$(PKG)_FILE     := json-glib-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/json-glib/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib $(BUILD)~ninja

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/json-glib) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Dintrospection=disabled -Dgtk_doc=disabled -Dtests=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
