# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libopenmpt
$(PKG)_WEBSITE  := https://lib.openmpt.org/libopenmpt/
$(PKG)_DESCR    := OpenMPT based module player library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.7.7
$(PKG)_CHECKSUM := 58c6a28972126828a6f658e084aee7aa8f8bfdb75a0bd0e345c7ff2a6d9ef08c
$(PKG)_SUBDIR   := libopenmpt-$($(PKG)_VERSION)+release.autotools
$(PKG)_FILE     := libopenmpt-$($(PKG)_VERSION)+release.autotools.tar.gz
$(PKG)_URL      := https://lib.openmpt.org/files/libopenmpt/src/$($(PKG)_FILE)
$(PKG)_DEPS     := cc zlib libflac libogg libvorbis portaudio

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://lib.openmpt.org/files/libopenmpt/src/' | \
    $(SED) -n 's,.*libopenmpt-\([0-9][^>]*\)+release\.autotools\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-doxygen-doc \
        --disable-doxygen-html \
        --disable-examples \
        --disable-tests \
        --disable-openmpt123 \
        --without-mpg123
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
