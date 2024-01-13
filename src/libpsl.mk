# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libpsl
$(PKG)_WEBSITE  := https://github.com/rockdaboot/libpsl
$(PKG)_DESCR    := C library for the Public Suffix List
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.21.5
$(PKG)_CHECKSUM := 1dcc9ceae8b128f3c0b3f654decd0e1e891afc6ff81098f227ef260449dae208
$(PKG)_GH_CONF  := rockdaboot/libpsl/releases/latest
$(PKG)_SUBDIR   := libpsl-$($(PKG)_VERSION)
$(PKG)_FILE     := libpsl-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/rockdaboot/libpsl/releases/download/$($(PKG)_VERSION)/$(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc meson-conf libunistring libidn2

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && LDFLAGS='$(LDFLAGS) -liconv' '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
