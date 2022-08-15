# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.2
$(PKG)_CHECKSUM := 6dec0d4a4e0c737b7035421a8c9c09771b76db9f2bd6c596fbc29db6da73f466
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib glib-networking sqlite brotli libpsl nghttp2 $(BUILD)~ninja

define $(PKG)_UPDATE
    $(call MXE_GET_GH_TAGS,GNOME/libsoup) | \
    grep -v '\([0-9]\+\.\)\{2\}9[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && LDFLAGS='$(LDFLAGS) -Wl,--allow-multiple-definition' '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dtests=false \
        -Dvapi=disabled \
        -Dgssapi=disabled \
        -Dintrospection=disabled \
        -Dtests=false \
        -Dsysprof=disabled \
        -Dtls_check=false \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
