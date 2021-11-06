# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libopenmpt
$(PKG)_WEBSITE  := https://lib.openmpt.org/libopenmpt/
$(PKG)_DESCR    := OpenMPT based module player library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.5.12
$(PKG)_CHECKSUM := 892aea7a599b5d21842bebf463b5aafdad5711be7008dd84401920c6234820af
$(PKG)_SUBDIR   := libopenmpt-$($(PKG)_VERSION)+release.autotools
$(PKG)_FILE     := libopenmpt-$($(PKG)_VERSION)+release.autotools.tar.gz
$(PKG)_URL      := https://lib.openmpt.org/files/libopenmpt/src/$($(PKG)_FILE)
$(PKG)_DEPS     := cc zlib flac ogg vorbis portaudio

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://lib.openmpt.org/files/libopenmpt/src/' | \
    $(SED) -n 's,.*libopenmpt-\([0-9][^>]*\)+release\.autotools\.tar.*,\1,p' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) \
                             --disable-openmpt123 \
                             --disable-examples \
                             --disable-tests \
                             --without-mpg123
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef