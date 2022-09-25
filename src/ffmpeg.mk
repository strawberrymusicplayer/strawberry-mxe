# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ffmpeg
$(PKG)_WEBSITE  := https://ffmpeg.org/
$(PKG)_DESCR    := A complete, cross-platform solution to record, convert and stream audio and video.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.1.2
$(PKG)_CHECKSUM := 39a0bcc8d98549f16c570624678246a6ac736c066cebdb409f9502e915b22f2b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://ffmpeg.org/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc yasm zlib bzip2 gnutls wavpack libvorbis libopus speex lame libcdio

# DO NOT ADD fdk-aac.
# Although it is free software, the license is not compatible with the GPL, and we'd like to enable GPL in our default ffmpeg build.
# See docs/index.html#potential-legal-issues

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ffmpeg.org/releases/' | \
    $(SED) -n 's,.*ffmpeg-\([0-9][^>]*\)\.tar.*,\1,p' | \
    grep -v 'alpha\|beta\|rc\|git' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        --cross-prefix='$(TARGET)'- \
        --enable-cross-compile \
        --arch=$(firstword $(subst -, ,$(TARGET))) \
        --target-os=mingw32 \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), --enable-static --disable-shared , --disable-static --enable-shared ) \
        --disable-$(if $(POSIX_THREADS),w32threads,pthreads) \
        --x86asmexe='$(TARGET)-yasm' \
        --extra-libs='-mconsole' \
        --disable-debug \
        --disable-doc \
        --disable-htmlpages \
        --disable-manpages \
        --disable-podpages \
        --disable-txtpages \
        --disable-libcdio \
        --enable-gpl \
        --enable-version3 \
        --enable-gnutls \
        --enable-libvorbis \
        --enable-libopus \
        --enable-libspeex \
        --enable-libmp3lame \
        $($(PKG)_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
