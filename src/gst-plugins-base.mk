# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-base
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-base.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.18.3
$(PKG)_CHECKSUM := dbfa20283848f0347a223dd8523dfb62e09e5220b21b1d157a8b0c8b67ba9f52
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib gstreamer liboil libxml2 ogg opus pango theora vorbis dlfcn-win32

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-base/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)' \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dtools=disabled \
        -Dgtk_doc=disabled \
        -Dorc=enabled \
        -Dadder=enabled \
        -Dapp=enabled \
        -Daudioconvert=enabled \
        -Daudiomixer=enabled \
        -Daudiorate=enabled \
        -Daudioresample=enabled \
        -Daudiotestsrc=enabled \
        -Dcompositor=enabled \
        -Dencoding=enabled \
        -Dgio=enabled \
        -Doverlaycomposition=enabled \
        -Dpbtypes=enabled \
        -Dplayback=enabled \
        -Drawparse=enabled \
        -Dsubparse=enabled \
        -Dtcp=enabled \
        -Dtypefind=enabled \
        -Dvideoconvert=disabled \
        -Dvideorate=disabled \
        -Dvideoscale=disabled \
        -Dvideotestsrc=disabled \
        -Dvolume=enabled \
        -Dalsa=disabled \
        -Dcdparanoia=disabled \
        -Dlibvisual=disabled \
        -Dogg=enabled \
        -Dopus=enabled \
        -Dpango=enabled \
        -Dtheora=disabled \
        -Dtremor=disabled \
        -Dvorbis=enabled \
        -Dx11=disabled \
        -Dxshm=disabled \
        -Dxvideo=disabled \
        -Dgl=disabled \
        -Dgl-graphene=disabled \
        -Dgl-jpeg=disabled \
        -Dgl-png=disabled

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )

endef

