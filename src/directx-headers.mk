# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := DirectX-Headers
$(PKG)_VERSION  := 1.619.4
$(PKG)_CHECKSUM := 427c4c20bdeb06022d706ba24cb14838b62cca4456a6072e826d7ffa706a4b1a
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/releases/latest, v
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
