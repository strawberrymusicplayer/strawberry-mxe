# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mesa
$(PKG)_WEBSITE  := https://mesa3d.org
$(PKG)_DESCR    := The Mesa 3D Graphics Library
$(PKG)_VERSION  := 22.0.3
$(PKG)_CHECKSUM := 9f2b30f5276a9abaf71aafc6979685e2636189de1a87aea2c9e69744a6d0ebb9
$(PKG)_SUBDIR   := mesa-$($(PKG)_VERSION)
$(PKG)_FILE     := mesa-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := ftp://ftp.freedesktop.org/pub/mesa/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf zlib

define $(PKG)_UPDATE
    $(call GET_LATEST_VERSION, https://archive.mesa3d.org, mesa-)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
    for i in EGL GLES GLES2 GLES3 KHR; do \
        $(INSTALL) -d "$(PREFIX)/$(TARGET)/include/$$i"; \
        $(INSTALL) -m 644 "$(1)/include/$$i/"* "$(PREFIX)/$(TARGET)/include/$$i/"; \
    done
endef
