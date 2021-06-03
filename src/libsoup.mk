# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.99.7
$(PKG)_CHECKSUM := 06c4895770916615cf8afd6c5758a2586427539ab291be66a06b87e50e89c30e
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib glib-networking libxml2 sqlite brotli libpsl nghttp2 $(BUILD)~ninja

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/libsoup) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson \
                                -Dtests=false \
                                -Dvapi=disabled \
                                -Dgssapi=disabled \
                                -Dintrospection=disabled \
                                -Dtests=false \
                                -Dsysprof=disabled \
                                '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
