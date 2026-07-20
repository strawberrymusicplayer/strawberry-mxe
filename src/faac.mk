# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faac
$(PKG)_WEBSITE  := http://sourceforge.net/projects/faac/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0
$(PKG)_CHECKSUM := 70bf59db35b2d129c6fe204200427950405d0a63bea3ff8fa8804648dde2cbce
$(PKG)_GH_CONF  := knik0/faac/releases/latest, faac-
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Db_lto=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
