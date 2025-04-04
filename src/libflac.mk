# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libflac
$(PKG)_WEBSITE  := https://www.xiph.org/flac/
$(PKG)_DESCR    := Free Lossless Audio Codec
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.0
$(PKG)_CHECKSUM := f2c1c76592a82ffff8413ba3c4a1299b6c7ab06c734dee03fd88630485c2b920
$(PKG)_GH_CONF  := xiph/flac/releases/latest
$(PKG)_SUBDIR   := flac-$($(PKG)_VERSION)
$(PKG)_FILE     := flac-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://github.com/xiph/flac/releases/download/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libogg $(BUILD)~nasm

define $(PKG)_BUILD
    cd '$(1)' && ./autogen.sh
    $(if $(BUILD_STATIC), \
        $(SED) -i 's/^\(Cflags:.*\)/\1 -DFLAC__NO_DLL/' \
            '$(1)/src/libFLAC/flac.pc.in' \
            '$(1)/src/libFLAC++/flac++.pc.in',)
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-rpath \
        --disable-doxygen-docs \
        --disable-examples \
        --disable-xmms-plugin \
        --disable-oggtest \
        --enable-cpplibs \
        --enable-ogg
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
