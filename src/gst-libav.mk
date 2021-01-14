# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-libav
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-libav.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.18.3
$(PKG)_CHECKSUM := ad20546bcd78ac1e7cf194666d73c4f33efeb62647d2b6af22993b540699e91c
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc ffmpeg gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly $(BUILD)~nasm

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-libav/refs,$(gstreamer_UPDATE))

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
