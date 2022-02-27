# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libvorbis
$(PKG)_WEBSITE  := https://xiph.org/vorbis/
$(PKG)_DESCR    := Vorbis audio compression library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.3.7
$(PKG)_CHECKSUM := 0e982409a9c3fc82ee06e08205b1355e5c6aa4c36bca58146ef399621b0ce5ab
$(PKG)_SUBDIR   := libvorbis-$($(PKG)_VERSION)
$(PKG)_FILE     := libvorbis-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://downloads.xiph.org/releases/vorbis/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libogg

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.xiph.org/downloads/' | \
    $(SED) -n 's,.*libvorbis-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-oggtest --disable-docs --disable-examples PKG_CONFIG='$(TARGET)-pkg-config'
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
