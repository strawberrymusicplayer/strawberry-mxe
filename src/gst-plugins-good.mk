# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-good
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-good.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.24.1
$(PKG)_CHECKSUM := c02ba5583863e0bd9e265e5e4a27a03a3c473eb9ec1c10b07238f7176d9368a2
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
        -Dgobject-cast-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-asserts=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
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
