# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libopenmpt
$(PKG)_WEBSITE  := https://lib.openmpt.org/libopenmpt/
$(PKG)_DESCR    := OpenMPT based module player library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.7
$(PKG)_CHECKSUM := 2174ac0f5a148ba684db768a47edf783eff9084fbca5fef6c997501643100163
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
