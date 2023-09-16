# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := json-glib
$(PKG)_WEBSITE  := https://gitlab.gnome.org/GNOME/json-glib
$(PKG)_DESCR    := JSON-GLib implements a full JSON parser and generator using GLib and GObject, and integrates JSON with GLib data types.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.0
$(PKG)_CHECKSUM := 97ef5eb92ca811039ad50a65f06633f1aae64792789307be7170795d8b319454
$(PKG)_SUBDIR   := json-glib-$($(PKG)_VERSION)
$(PKG)_FILE     := json-glib-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/json-glib/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib $(BUILD)~ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/json-glib/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\)<.*,\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Dintrospection=disabled -Dgtk_doc=disabled -Dtests=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
