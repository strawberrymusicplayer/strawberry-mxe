# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := orc
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/projects/orc.html
$(PKG)_DESCR    := ORC Acceleration
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.41
$(PKG)_CHECKSUM := cb1bfd4f655289cd39bc04642d597be9de5427623f0861c1fc19c08d98467fa2
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
        -Dgtk_doc=disabled \
        -Dtests=disabled \
        -Dtools=disabled \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
