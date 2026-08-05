# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-bad
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-bad.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.28.6
$(PKG)_CHECKSUM := 6636f2c2289ceda52c4aba971338c81e2b5780d3381bd3673c1c116ec87587c3
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good libgcrypt libxml2 opus faad2 faac musepack chromaprint libopenmpt fdk-aac libgme libbs2b

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        --auto-features=disabled \
        -Dexamples=disabled \
        -Dtools=enabled \
        -Dtests=disabled \
        -Dintrospection=disabled \
        -Dnls=enabled \
        -Dorc=enabled \
        -Dgpl=enabled \
        -Daiff=enabled \
        -Dasfmux=enabled \
        -Dmpegtsdemux=enabled \
        -Dbs2b=enabled \
        -Ddash=enabled \
        -Ddirectsound=enabled \
        -Dfaac=enabled \
        -Dfaad=enabled \
        -Dfdkaac=enabled \
        -Dgme=enabled \
        -Dmusepack=enabled \
        -Dopenmpt=enabled \
        -Dopus=enabled \
        -Dwasapi=enabled \
        -Dwasapi2=enabled \
        -Dasio=enabled \
        -Dhls=enabled \
        -Dhls-crypto=libgcrypt \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
