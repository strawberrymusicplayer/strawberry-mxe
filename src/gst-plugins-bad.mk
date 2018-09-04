# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-bad
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-bad.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ae7ecfc
$(PKG)_CHECKSUM := 64b8351778e6e7bf43b9db49c0fab3912aa2b457eced72a1487cd23a8834e8a5
$(PKG)_GH_CONF  := GStreamer/gst-plugins-bad/branches/master
#$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
#$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
#$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc opus faad2 gstreamer gst-plugins-base

#$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-bad/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/autogen.sh' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --disable-debug \
        --disable-examples \
        --disable-adpcmdec \
        --disable-adpcmenc \
        --disable-videoframe_audiolevel \
        --disable-audiobuffersplit \
        --disable-audiofxbad \
        --disable-audiolatency \
        --disable-audiomixmatrix \
        --disable-compositor \
        --disable-audiovisualizers \
        --disable-autoconvert \
        --disable-bayer \
        --disable-camerabin2 \
        --disable-coloreffects \
        --disable-debugutils \
        --disable-dvbsuboverlay \
        --disable-dvdspu \
        --disable-faceoverlay \
        --disable-festival \
        --disable-fieldanalysis \
        --disable-freeverb \
        --disable-frei0r \
        --disable-gaudieffects \
        --disable-geometrictransform \
        --disable-gdp \
        --disable-id3tag \
        --disable-inter \
        --disable-interlace \
        --disable-ivfparse \
        --disable-ivtc \
        --disable-jp2kdecimator \
        --disable-jpegformat \
        --disable-librfb \
        --disable-midi \
        --disable-mpegdemux \
        --disable-mpegtsdemux \
        --disable-mpegtsmux \
        --disable-mpegpsmux \
        --disable-mxf \
        --disable-netsim \
        --disable-onvif \
        --disable-pcapparse \
        --disable-pnm \
        --disable-proxy \
        --disable-rawparse \
        --disable-removesilence \
        --disable-sdp \
        --disable-segmentclip \
        --disable-siren \
        --disable-smooth \
        --disable-speed \
        --disable-subenc \
        --disable-stereo \
        --disable-timecode \
        --disable-videofilters \
        --disable-videoparsers \
        --disable-videosignal \
        --disable-vmnc \
        --disable-y4m \
        --disable-yadif \
        --disable-directsound \
        --disable-wasapi \
        --disable-direct3d \
        --disable-winscreencap \
        --disable-winks \
        --disable-android_media \
        --disable-apple_media \
        --disable-bluez \
        --disable-avc \
        --disable-shm \
        --disable-ipcpipeline \
        --disable-vcd \
        --disable-opensles \
        --disable-uvch264 \
        --disable-cuda \
        --disable-tinyalsa \
        --disable-msdk \
        --disable-assrender \
        --disable-aom \
        --disable-voamrwbenc \
        --disable-voaacenc \
        --disable-bs2b \
        --disable-bz2 \
        --disable-chromaprint \
        --disable-curl \
        --disable-dash \
        --disable-dc1394 \
        --disable-decklink \
        --disable-directfb \
        --disable-wayland \
        --disable-webp \
        --disable-daala \
        --disable-dts \
        --disable-resindvd \
        --disable-fbdev \
        --disable-fdk_aac \
        --disable-flite \
        --disable-gsm \
        --disable-fluidsynth \
        --disable-kate \
        --disable-kms \
        --disable-ladspa \
        --disable-lcms2 \
        --disable-lv2 \
        --disable-libde265 \
        --disable-libmms \
        --disable-srt \
        --disable-srtp \
        --disable-dtls \
        --disable-ttml \
        --disable-modplug \
        --disable-mpeg2enc \
        --disable-mplex \
        --disable-neon \
        --disable-ofa \
        --disable-openal \
        --disable-opencv \
        --disable-openexr \
        --disable-openh264 \
        --disable-openjpeg \
        --disable-openmpt \
        --disable-openni2 \
        --disable-rsvg \
        --disable-gl \
        --disable-vulkan \
        --disable-teletextdec \
        --disable-wildmidi \
        --disable-smoothstreaming \
        --disable-sndfile \
        --disable-soundtouch \
        --disable-spc \
        --disable-gme \
        --disable-dvb \
        --disable-acm \
        --disable-vdpau \
        --disable-sbc \
        --disable-zbar \
        --disable-rtmp \
        --disable-spandsp \
        --disable-hls \
        --disable-x265 \
        --disable-webrtcdsp \
        --disable-webrtc \
        --enable-faac \
        --enable-faad \
        --enable-aiff \
        --enable-asfmux \
        --enable-opus \
        --enable-musepack

    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )
endef
