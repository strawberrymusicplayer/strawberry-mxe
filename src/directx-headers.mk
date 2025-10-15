# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := DirectX-Headers
$(PKG)_VERSION  := 1.618.2
$(PKG)_CHECKSUM := 62004f45e2ab00cbb5c7f03c47262632c22fbce0a237383fc458d9324c44cf36
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/releases/latest, v
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
