#This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-ugly
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-ugly.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.18.0
$(PKG)_CHECKSUM := 686644e45e08258ae240c4519376668ad8d34ea6d0f6ab556473c317bfb7e082
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad lame libcdio

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-ugly/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)' \
        -Dtests=disabled \
        -Dorc=enabled \
        -Dasfdemux=enabled \
        -Ddvdlpcmdec=disabled \
        -Ddvdsub=disabled \
        -Drealmedia=disabled \
        -Dxingmux=disabled \
        -Da52dec=disabled \
        -Damrnb=disabled \
        -Damrwbdec=disabled \
        -Dcdio=enabled \
        -Ddvdread=disabled \
        -Dmpeg2dec=disabled \
        -Dsidplay=disabled \
        -Dx264=disabled

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
