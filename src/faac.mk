# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faac
$(PKG)_WEBSITE  := http://sourceforge.net/projects/faac/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.40
$(PKG)_CHECKSUM := 3ef4cc1fa6a750003602adc6eea892ca3815becd9145797b787f0999e8b2b89c
$(PKG)_GH_CONF  := knik0/faac/releases/latest, faac-
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
