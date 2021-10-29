# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pango
$(PKG)_WEBSITE  := https://www.pango.org/
$(PKG)_DESCR    := Pango
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.49.2
$(PKG)_CHECKSUM := 9d67612c58be86b118d2dbf28498f4e6395033b658cdfd6787a9b4b368055fd6
$(PKG)_SUBDIR   := pango-$($(PKG)_VERSION)
$(PKG)_FILE     := pango-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib fontconfig freetype cairo harfbuzz fribidi $(BUILD)~ninja

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/pango) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson -Dintrospection=disabled '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
