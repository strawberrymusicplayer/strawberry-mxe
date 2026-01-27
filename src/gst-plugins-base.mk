# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-base
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-base.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.28.0
$(PKG)_CHECKSUM := eace79d63bd2edeb2048777ea9f432d8b6e7336e656cbc20da450f6235758b31
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib gstreamer libogg libopus libvorbis dlfcn-win32

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && CFLAGS='-std=gnu17' '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        --auto-features=disabled \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dtools=enabled \
        -Dintrospection=disabled \
        -Dnls=enabled \
        -Dorc=enabled \
        -Ddoc=disabled \
        -Dadder=enabled \
        -Dapp=enabled \
        -Daudioconvert=enabled \
        -Daudiomixer=enabled \
        -Daudiorate=enabled \
        -Daudioresample=enabled \
        -Daudiotestsrc=enabled \
        -Ddsd=enabled \
        -Dencoding=enabled \
        -Dgio=enabled \
        -Dgio-typefinder=enabled \
        -Dpbtypes=enabled \
        -Dplayback=enabled \
        -Dtcp=enabled \
        -Dtypefind=enabled \
        -Dvolume=enabled \
        -Dogg=enabled \
        -Dopus=enabled \
        -Dvorbis=enabled \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )

endef

