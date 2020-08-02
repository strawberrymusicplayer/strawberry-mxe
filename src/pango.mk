# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pango
$(PKG)_WEBSITE  := https://www.pango.org/
$(PKG)_DESCR    := Pango
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.45.4
$(PKG)_CHECKSUM := 3843c2eda760a4dfa998cc9c12db25da1da26ae01e8d847a9afeba684b7bde7b
$(PKG)_SUBDIR   := pango-$($(PKG)_VERSION)
$(PKG)_FILE     := pango-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc ninja glib fontconfig freetype cairo harfbuzz fribidi

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/pango) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson \
                                -Dintrospection=false \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
