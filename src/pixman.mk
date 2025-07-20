# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pixman
$(PKG)_WEBSITE  := http://www.pixman.org/
$(PKG)_DESCR    := Pixman is a low-level software library for pixel manipulation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.46.4
$(PKG)_CHECKSUM := d09c44ebc3bd5bee7021c79f922fe8fb2fb57f7320f55e97ff9914d2346a591c
$(PKG)_SUBDIR   := pixman-$($(PKG)_VERSION)
$(PKG)_FILE     := pixman-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_URL_2    := https://xorg.freedesktop.org/archive/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf libpng

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.cairographics.org/releases/?C=M;O=D' | \
    $(SED) -n 's,.*"pixman-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
