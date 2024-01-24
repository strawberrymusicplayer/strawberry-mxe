# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-good
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-good.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.22.9
$(PKG)_CHECKSUM := 26959fcfebfff637d4ea08ef40316baf31b61bb7729820b0684e800c3a1478b6
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib libflac speex wavpack mpg123 lame twolame libsoup taglib gstreamer gst-plugins-base

$(PKG)_UPDATE = $(gstreamer_UPDATE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Ddoc=disabled \
        -Dorc=enabled \
        -Dalpha=disabled \
        -Dapetag=enabled \
        -Daudiofx=enabled \
        -Daudioparsers=enabled \
        -Dauparse=disabled \
        -Dautodetect=enabled \
        -Davi=disabled \
        -Dcutter=disabled \
        -Ddebugutils=disabled \
        -Ddeinterlace=disabled \
        -Ddtmf=disabled \
        -Deffectv=disabled \
        -Dequalizer=enabled \
        -Dflv=disabled \
        -Dflx=disabled \
        -Dgoom=disabled \
        -Dgoom2k1=disabled \
        -Dicydemux=enabled \
        -Did3demux=enabled \
        -Dimagefreeze=disabled \
        -Dinterleave=disabled \
        -Disomp4=enabled \
        -Dlaw=disabled \
        -Dlevel=disabled \
        -Dmatroska=disabled \
        -Dmonoscope=disabled \
        -Dmultifile=disabled \
        -Dmultipart=disabled \
        -Dreplaygain=enabled \
        -Drtp=enabled \
        -Drtpmanager=disabled \
        -Drtsp=enabled \
        -Dshapewipe=disabled \
        -Dsmpte=disabled \
        -Dspectrum=enabled \
        -Dudp=enabled \
        -Dvideobox=disabled \
        -Dvideocrop=disabled \
        -Dvideofilter=disabled \
        -Dvideomixer=disabled \
        -Dwavenc=enabled \
        -Dwavparse=enabled \
        -Dxingmux=enabled \
        -Dy4m=disabled \
        -Dadaptivedemux2=enabled \
        -Daalib=disabled \
        -Dbz2=disabled \
        -Dcairo=disabled \
        -Ddirectsound=enabled \
        -Ddv=disabled \
        -Ddv1394=disabled \
        -Dflac=enabled \
        -Dgdk-pixbuf=disabled \
        -Dgtk3=disabled \
        -Djack=disabled \
        -Djpeg=disabled \
        -Dlame=enabled \
        -Dlibcaca=disabled \
        -Dmpg123=enabled \
        -Doss=disabled \
        -Doss4=disabled \
        -Dosxaudio=disabled \
        -Dosxvideo=disabled \
        -Dpng=disabled \
        -Dpulse=disabled \
        -Dshout2=disabled \
        -Dspeex=enabled \
        -Dtaglib=enabled \
        -Dtwolame=enabled \
        -Dvpx=disabled \
        -Dwaveform=enabled \
        -Dwavpack=enabled \
        -Dsoup=enabled \
        -Dqt5=disabled \
        -Dximagesrc=disabled \
        -Dv4l2=disabled \
        -Dv4l2-libv4l2=disabled \
        -Dv4l2-gudev=disabled \
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
