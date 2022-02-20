# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gst-plugins-bad
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gst-plugins-bad.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.20.0
$(PKG)_CHECKSUM := 015b8d4d9a395ebf444d40876867a2034dd3304b3ad48bc3a0dd0c1ee71dc11d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gstreamer gst-plugins-base gst-plugins-good libgcrypt libxml2 libopus faad2 faac libmpcdec chromaprint libopenmpt

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-bad/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dexamples=disabled \
        -Dgpl=enabled \
        -Dorc=enabled \
        -Daccurip=disabled \
        -Dadpcmdec=disabled \
        -Dadpcmenc=disabled \
        -Daiff=enabled \
        -Dasfmux=enabled \
        -Daudiobuffersplit=disabled \
        -Daudiofxbad=disabled \
        -Daudiolatency=disabled \
        -Daudiomixmatrix=disabled \
        -Daudiovisualizers=disabled \
        -Dautoconvert=disabled \
        -Dbayer=disabled \
        -Dcamerabin2=disabled \
        -Dcoloreffects=disabled \
        -Ddebugutils=disabled \
        -Ddvbsuboverlay=disabled \
        -Ddvdspu=disabled \
        -Dfaceoverlay=disabled \
        -Dfestival=disabled \
        -Dfieldanalysis=disabled \
        -Dfreeverb=disabled \
        -Dfrei0r=disabled \
        -Dgaudieffects=disabled \
        -Dgeometrictransform=disabled \
        -Dgdp=disabled \
        -Did3tag=disabled \
        -Dinter=disabled \
        -Dinterlace=disabled \
        -Divfparse=disabled \
        -Divtc=disabled \
        -Djp2kdecimator=disabled \
        -Djpegformat=disabled \
        -Dlibrfb=disabled \
        -Dmidi=disabled \
        -Dmpegdemux=disabled \
        -Dmpegpsmux=disabled \
        -Dmpegtsdemux=disabled \
        -Dmpegtsmux=disabled \
        -Dmxf=disabled \
        -Dnetsim=disabled \
        -Donvif=disabled \
        -Dpcapparse=disabled \
        -Dpnm=disabled \
        -Dproxy=disabled \
        -Drawparse=disabled \
        -Dremovesilence=disabled \
        -Dsdp=disabled \
        -Dsegmentclip=disabled \
        -Dsiren=disabled \
        -Dsmooth=disabled \
        -Dspeed=disabled \
        -Dsubenc=disabled \
        -Dtimecode=disabled \
        -Dvideofilters=disabled \
        -Dvideoframe_audiolevel=disabled \
        -Dvideoparsers=disabled \
        -Dvideosignal=disabled \
        -Dvmnc=disabled \
        -Dy4m=disabled \
        -Dopencv=disabled \
        -Dwayland=disabled \
        -Dx11=disabled \
        -Daom=disabled \
        -Dassrender=disabled \
        -Dbluez=disabled \
        -Dbs2b=disabled \
        -Dbz2=disabled \
        -Dchromaprint=enabled \
        -Dclosedcaption=disabled \
        -Dcolormanagement=disabled \
        -Dcurl=disabled \
        -Dcurl-ssh2=disabled \
        -Dd3dvideosink=disabled \
        -Ddash=enabled \
        -Ddc1394=disabled \
        -Ddecklink=disabled \
        -Ddirectfb=disabled \
        -Ddirectsound=enabled \
        -Ddtls=disabled \
        -Ddts=disabled \
        -Ddvb=disabled \
        -Dfaac=enabled \
        -Dfaad=enabled \
        -Dfbdev=disabled \
        -Dfdkaac=disabled \
        -Dflite=disabled \
        -Dfluidsynth=disabled \
        -Dgl=disabled \
        -Dgsm=disabled \
        -Dgme=disabled \
        -Dipcpipeline=disabled \
        -Diqa=disabled \
        -Dkate=disabled \
        -Dkms=disabled \
        -Dladspa=disabled \
        -Dlibde265=disabled \
        -Dlv2=disabled \
        -Dmodplug=disabled \
        -Dmpeg2enc=disabled \
        -Dmplex=disabled \
        -Dmsdk=disabled \
        -Dmusepack=auto \
        -Dneon=disabled \
        -Dopenal=disabled \
        -Dopenexr=disabled \
        -Dopenh264=disabled \
        -Dopenjpeg=disabled \
        -Dopenmpt=enabled \
        -Dopenni2=disabled \
        -Dopensles=disabled \
        -Dopus=enabled \
        -Dresindvd=disabled \
        -Drsvg=disabled \
        -Drtmp=disabled \
        -Dsbc=disabled \
        -Dsctp=disabled \
        -Dshm=disabled \
        -Dsmoothstreaming=disabled \
        -Dsndfile=disabled \
        -Dsoundtouch=disabled \
        -Dspandsp=disabled \
        -Dsrt=disabled \
        -Dsrtp=disabled \
        -Dteletext=disabled \
        -Dtinyalsa=disabled \
        -Dttml=disabled \
        -Duvch264=disabled \
        -Dvoaacenc=disabled \
        -Dvoamrwbenc=disabled \
        -Dvulkan=disabled \
        -Dwasapi=enabled \
        -Dwebp=disabled \
        -Dwebrtc=disabled \
        -Dwebrtcdsp=disabled \
        -Dwildmidi=disabled \
        -Dwinks=disabled \
        -Dwinscreencap=disabled \
        -Dx265=disabled \
        -Dzbar=disabled \
        -Dwpe=disabled \
        -Dhls=disabled \
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
