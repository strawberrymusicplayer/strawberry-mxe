# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libpsl
$(PKG)_WEBSITE  := https://github.com/rockdaboot/libpsl
$(PKG)_DESCR    := C library for the Public Suffix List
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.23.1
$(PKG)_CHECKSUM := 8fbb03054556498ba9c4cc48fcaa36a4483748c6504a65bdb9ba348f555b0e56
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
