# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-libav
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-libav.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5e4f6ca
$(PKG)_CHECKSUM := 1dc3c823ab4c527942936c87e0c0933ddb5087657b59dfe4d8b26274ef448425
$(PKG)_GH_CONF  := GStreamer/gst-libav/branches/master
#$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
#$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
#$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gst-plugins-base $(BUILD)~nasm

#$(PKG)_UPDATE = $(subst gstreamer/refs,gst-libav/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/libav/configure' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/gas-preprocessor/gas-preprocessor.pl' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/libav/ffbuild/config.sh' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/libav/ffbuild/version.sh' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/libav/ffbuild/libversion.sh' && \
    chmod u+x '$(SOURCE_DIR)/gst-libs/ext/libav/ffbuild/pkgconfig_generate.sh' && \
    '$(SOURCE_DIR)/autogen.sh' && \
    '$(SOURCE_DIR)/configure' $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
