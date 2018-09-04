# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-base
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-base.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 14031f1
$(PKG)_CHECKSUM := c2af67561456ac575aff5ffd5141b94165c7895ff41d2c4a8bd296da8f45bfdf
$(PKG)_GH_CONF  := GStreamer/gst-plugins-base/branches/master
#$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
#$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
#$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib gstreamer liboil libxml2 ogg pango theora vorbis dlfcn-win32

#$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-base/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/autogen.sh' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --disable-debug \
        --disable-examples \
        --disable-opengl \
        --disable-gles2 \
        --disable-egl \
        --disable-wgl \
        --disable-glx \
        --disable-cocoa \
        --disable-x11 \
        --disable-wayland \
        --disable-dispmanx \
        --disable-encoding \
        --disable-videoconvert \
        --disable-videotestsrc \
        --disable-videorate \
        --disable-videoscale \
        --disable-x \
        --disable-xvideo \
        --disable-xshm \
        --disable-alsa \
        --disable-cdparanoia \
        --disable-gl \
        --disable-libvisual \
        --disable-theora \
        --enable-app \
        --enable-audioconvert \
        --enable-gio \
        --enable-playback \
        --enable-audioresample \
        --enable-volume \
        --enable-ogg \
        --enable-opus \
        --enable-vorbis

    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
