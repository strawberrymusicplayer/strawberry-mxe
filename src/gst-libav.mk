# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-libav
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-libav.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.18.1
$(PKG)_CHECKSUM := 39a717bc2613efbbba19df3cf5cacff0987471fc8281ba2c5dcdeaded79c2ed8
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc ffmpeg gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly $(BUILD)~nasm

#$(PKG)_UPDATE = $(subst gstreamer/refs,gst-libav/refs,$(gstreamer_UPDATE))

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)' -Dexamples=disabled -Dtests=disabled -Dgtk_doc=disabled

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
