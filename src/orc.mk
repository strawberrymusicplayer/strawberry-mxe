# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := orc
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/projects/orc.html
$(PKG)_DESCR    := ORC Acceleration
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.44
$(PKG)_CHECKSUM := 4aeb97aea2b58224029dc2b23d7d064cfa990cb4fb8c4da440bcbe9c95bc5d2d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gstreamer.freedesktop.org/src/orc/' | \
    $(SED) -n "s,.*orc-\([0-9]*\.[0-9]*\.[0-9]*\)\.tar\.xz.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dbenchmarks=disabled \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dtools=disabled \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
