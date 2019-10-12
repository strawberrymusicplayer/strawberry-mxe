# This file is part of MXE.
# See index.html for further information.

PKG             := xine-lib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.9
$(PKG)_CHECKSUM := 32b34e8049feb762d75a551d5d2cdb56c396fdd83e35b9b7de5fd08e498e948d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/xine/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc pthreads mman-win32 zlib flac faad2 libmad speex theora vorbis wavpack libcdio libmpcdec

define $(PKG)_UPDATE
    $(WGET) -q -O- -t 2 --timeout=6 'http://www.xine-project.org/releases' | \
    $(SED) -e 's,<a,\n<a,g' | \
    $(SED) -n 's,.*xine-lib-\([0-9][^"]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    # rebuild configure script as one of the patches modifies configure.ac
    cd '$(1)' && autoreconf -fi

    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-static \
        --enable-shared \
        --enable-asf \
        --enable-faad \
        --enable-dts \
        --enable-mad \
        --enable-musepack \
        --disable-modplug \
        --disable-mmap \
        --disable-nls \
        --disable-real-codecs \
        --disable-coreaudio \
        --disable-irixal \
        --disable-oss \
        --disable-sunaudio \
        --disable-aalib \
        --disable-dha-kmod \
        --disable-directfb \
        --disable-dxr3 \
        --disable-fb \
        --disable-macosx-video \
        --disable-opengl \
        --disable-glu \
        --disable-vidix \
        --disable-xinerama \
        --disable-static-xv \
        --disable-xvmc \
        --disable-vdpau \
        --disable-vaapi \
        --disable-dvb \
        --disable-gnomevfs \
        --disable-samba \
        --disable-v4l \
        --disable-v4l2 \
        --disable-libv4l \
        --disable-vcd \
        --disable-vdr \
        --disable-bluray \
        --disable-avformat \
        --disable-a52dec \
        --disable-nosefart \
        --disable-ffmpeg \
        --disable-postproc \
        --disable-gdkpixbuf \
        --disable-libjpeg \
        --disable-libmpeg2new \
        --disable-mlib \
        --disable-mlib-lazyload \
        --disable-mng \
        --disable-real-codecs \
        --disable-vpx \
        --disable-mmal \
        --with-libflac \
        --with-wavpack \
        --with-vorbis \
        --with-theora \
        --with-speex \
        --without-sdl \
        --without-x \
        --without-alsa \
        --without-esound \
        --without-arts \
        --without-fusionsound \
        --without-external-libdts \
        --without-jack \
        --without-pulseaudio \
        --without-dxheaders \
        --without-xcb \
        --without-imagemagick \
        --without-openhevc \
        CFLAGS='-I$(1)/win32/include' \
        PTHREAD_LIBS='-lpthread -lws2_32' \
        LIBS="`$(TARGET)-pkg-config --libs libmng` -logg"
    $(SED) -i 's,[\s^]*sed , $(SED) ,g' '$(1)/src/combined/ffmpeg/Makefile'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

$(PKG)_BUILD_STATIC =
