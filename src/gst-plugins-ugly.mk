#This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-ugly
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-ugly.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.24.5
$(PKG)_CHECKSUM := 333267b6e00770440a4a00402910dd59ed8fd619eaebf402815fbe111da7776d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad libcdio

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        --auto-features=disabled \
        -Dnls=enabled \
        -Dorc=enabled \
        -Dtests=disabled \
        -Dgobject-cast-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-asserts=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Dglib-checks=$(if '$(MESON_BUILD_TYPE)' = 'debug',enabled,disabled) \
        -Ddoc=disabled \
        -Dgpl=enabled \
        -Dasfdemux=enabled \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
