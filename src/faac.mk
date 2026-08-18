# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faac
$(PKG)_WEBSITE  := http://sourceforge.net/projects/faac/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1
$(PKG)_CHECKSUM := 1d4b890c7d767361987d80afdacdd654d23a748b4a273d743c174c2d57e9bce5
$(PKG)_GH_CONF  := knik0/faac/releases/latest, faac-
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Db_lto=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
