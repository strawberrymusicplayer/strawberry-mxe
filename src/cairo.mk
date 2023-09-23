# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cairo
$(PKG)_WEBSITE  := https://cairographics.org/
$(PKG)_DESCR    := Cairo is a 2D graphics library with support for multiple output devices
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.18.0
$(PKG)_CHECKSUM := 243a0736b978a33dee29f9cca7521733b78a65b5418206fef7bd1c3d4cf10b64
$(PKG)_SUBDIR   := cairo-$($(PKG)_VERSION)
$(PKG)_FILE     := cairo-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc fontconfig freetype-bootstrap glib libpng lzo pixman zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://cairographics.org/releases/?C=M;O=D' | \
    $(SED) -n 's,.*"cairo-\([0-9]\.[0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dfontconfig=enabled \
        -Dfreetype=enabled \
        -Dzlib=enabled \
        -Dpng=enabled \
        -Dtests=disabled \
        -Dgtk_doc=false \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
