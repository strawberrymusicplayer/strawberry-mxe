# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-good
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-good.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.26.1
$(PKG)_CHECKSUM := fcdcb2f77620a599557b2843d1c6c55c2b660f5fc28222b542847d11d9ca982f
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib libflac speex wavpack mpg123 lame twolame libsoup taglib gstreamer gst-plugins-base

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        --auto-features=disabled \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dnls=enabled \
        -Dorc=enabled \
        -Dasm=enabled \
        -Ddoc=disabled \
        -Dapetag=enabled \
        -Daudiofx=enabled \
        -Daudioparsers=enabled \
        -Dautodetect=enabled \
        -Dequalizer=enabled \
        -Dicydemux=enabled \
        -Did3demux=enabled \
        -Disomp4=enabled \
        -Dreplaygain=enabled \
        -Drtp=enabled \
        -Drtsp=enabled \
        -Dspectrum=enabled \
        -Dudp=enabled \
        -Dwavenc=enabled \
        -Dwavparse=enabled \
        -Dxingmux=enabled \
        -Dadaptivedemux2=enabled \
        -Ddirectsound=enabled \
        -Dflac=enabled \
        -Dlame=enabled \
        -Dmpg123=enabled \
        -Dspeex=enabled \
        -Dtaglib=enabled \
        -Dtwolame=enabled \
        -Dwaveform=enabled \
        -Dwavpack=enabled \
        -Dsoup=enabled \
        -Dhls-crypto=openssl \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )

endef
