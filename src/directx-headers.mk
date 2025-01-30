# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := DirectX-Headers
$(PKG)_VERSION  := 1.615.0
$(PKG)_CHECKSUM := 5394360b517f431949d751f3bcb4150313f28815aded514531c7aaea81bac314
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/releases/latest, v
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
