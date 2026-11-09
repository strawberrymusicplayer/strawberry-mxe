# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := DirectX-Headers
$(PKG)_VERSION  := 1.620.2
$(PKG)_CHECKSUM := 2b916ef1be5db35313f56d60499274fed39db37b54a1f0befa8aa49041c14855
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/releases/latest, v
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
