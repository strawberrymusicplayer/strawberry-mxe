# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := DirectX-Headers
$(PKG)_VERSION  := 1.619.1
$(PKG)_CHECKSUM := 6193774904c940eebb9b0c51b816b93dd776cfeb25a951f0f4a58f22387e5008
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/releases/latest, v
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
