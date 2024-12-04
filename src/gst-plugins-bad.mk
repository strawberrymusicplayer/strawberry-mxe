# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-bad
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-bad.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.24.10
$(PKG)_CHECKSUM := 1707e3103950c9baed364a8af2ba0495d6b113fcd36e1062dda5f582b8f8904d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good libgcrypt libxml2 libopus faad2 faac musepack chromaprint libopenmpt fdk-aac libgme libbs2b

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
        -Dgobject-cast-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-asserts=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dextra-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dgpl=enabled \
        -Daiff=enabled \
        -Dasfmux=enabled \
        -Did3tag=enabled \
        -Dmpegdemux=enabled \
        -Dmpegpsmux=enabled \
        -Dmpegtsdemux=enabled \
        -Dmpegtsmux=enabled \
        -Dremovesilence=enabled \
        -Daes=enabled \
        -Dbluez=enabled \
        -Dbs2b=enabled \
        -Dchromaprint=enabled \
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
