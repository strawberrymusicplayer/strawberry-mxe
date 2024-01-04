# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pixman
$(PKG)_WEBSITE  := http://www.pixman.org/
$(PKG)_DESCR    := Pixman is a low-level software library for pixel manipulation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.43.0
$(PKG)_CHECKSUM := a65c28209858fb16bee50d809c80f90a8e415c0e4fd8321078a1822785a5560a
$(PKG)_SUBDIR   := pixman-$($(PKG)_VERSION)
$(PKG)_FILE     := pixman-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_URL_2    := https://xorg.freedesktop.org/archive/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libpng

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
