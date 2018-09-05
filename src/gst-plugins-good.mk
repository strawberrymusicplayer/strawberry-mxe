# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-good
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-good.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.14.2
$(PKG)_CHECKSUM := c0575e2811860bfff59b865b8d125153859a01f0615fa41e279b64d88d25caad
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib flac liboil libsoup speex taglib wavpack lame twolame dlfcn-win32 gstreamer gst-plugins-base

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-good/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    # The value for WAVE_FORMAT_DOLBY_AC3_SPDIF comes from vlc and mplayer:
    #   https://www.videolan.org/developers/vlc/doc/doxygen/html/vlc__codecs_8h-source.html
    #   https://lists.mplayerhq.hu/pipermail/mplayer-cvslog/2004-August/019283.html
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --disable-debug \
        --disable-examples \
        --disable-alpha \
        --disable-auparse \
        --disable-avi \
        --disable-cutter \
        --disable-debugutils \
        --disable-deinterlace \
        --disable-dtmf \
        --disable-effectv \
        --disable-flv \
        --disable-flx \
        --disable-goom \
        --disable-goom2k1 \
        --disable-imagefreeze \
        --disable-interleave \
        --disable-law \
        --disable-level \
        --disable-matroska \
        --disable-monoscope \
        --disable-multifile \
        --disable-multipart \
        --disable-rtp \
        --disable-rtpmanager \
        --disable-rtsp \
        --disable-shapewipe \
        --disable-smpte \
        --disable-videobox \
        --disable-videocrop \
        --disable-videofilter \
        --disable-videomixer \
        --disable-y4m \
        --disable-oss \
        --disable-oss4 \
        --disable-osx_audio \
        --disable-osx_video \
        --disable-gst_v4l2 \
        --disable-v4l2-probe \
        --disable-x \
        --disable-aalib \
        --disable-aalibtest \
        --disable-cairo \
        --disable-gdk_pixbuf \
        --disable-gtk3 \
        --disable-jack \
        --disable-jpeg \
        --disable-libcaca \
        --disable-libdv \
        --disable-libpng \
        --disable-mpg123 \
        --disable-pulse \
        --disable-dv1394 \
        --disable-shout2 \
        --disable-vpx \
        --disable-zlib \
        --disable-bz2 \
        --enable-apetag \
        --enable-audiofx \
        --enable-audioparsers
        --enable-autodetect \
        --enable-equalizer \
        --enable-icydemux \
        --enable-id3demux \
        --enable-replaygain \
        --enable-spectrum \
        --enable-wavenc \
        --enable-wavparse \
        --enable-directsound \
        --enable-waveform \
        --enable-flac \
        --enable-lame \
        --enable-qt \
        --enable-speex \
        --enable-taglib \
        --enable-twolame \
        --enable-wavpack \
        --enable-isomp4 \
        --enable-udp \
        --enable-soup

        $(if $(BUILD_SHARED), --disable-shout2) \
        --disable-x
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS) CFLAGS='-DWAVE_FORMAT_DOLBY_AC3_SPDIF=0x0092'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install CFLAGS='-DWAVE_FORMAT_DOLBY_AC3_SPDIF=0x0092'

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
