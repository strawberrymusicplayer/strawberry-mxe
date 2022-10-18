# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pixman
$(PKG)_WEBSITE  := http://www.pixman.org/
$(PKG)_DESCR    := Pixman is a low-level software library for pixel manipulation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.42.0
$(PKG)_CHECKSUM := d8dccef84eb81d916a830d0ceeb2caad89888fedb9351d9a49558a34d3e6666c
$(PKG)_SUBDIR   := pixman-$($(PKG)_VERSION)
$(PKG)_FILE     := pixman-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_URL_2    := https://xorg.freedesktop.org/archive/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libpng

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.cairographics.org/releases/?C=M;O=D' | \
    $(SED) -n 's,.*"pixman-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --enable-libpng --disable-gtk
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
