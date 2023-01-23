#This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-ugly
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-ugly.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.22.0
$(PKG)_CHECKSUM := a644dc981afa2d8d3a913f763ab9523c0620ee4e65a7ec73c7721c29da3c5a0c
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad libcdio

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dtests=disabled \
        -Ddoc=disabled \
        -Dgpl=enabled \
        -Dorc=enabled \
        -Dasfdemux=enabled \
        -Ddvdlpcmdec=disabled \
        -Ddvdsub=disabled \
        -Drealmedia=disabled \
        -Dxingmux=enabled \
        -Da52dec=disabled \
        -Damrnb=disabled \
        -Damrwbdec=disabled \
        -Dcdio=enabled \
        -Ddvdread=disabled \
        -Dmpeg2dec=disabled \
        -Dsidplay=disabled \
        -Dx264=disabled \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
