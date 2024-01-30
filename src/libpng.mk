# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libpng
$(PKG)_WEBSITE  := http://www.libpng.org/pub/png/
$(PKG)_DESCR    := Portable Network Graphics Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.42
$(PKG)_CHECKSUM := c919dbc11f4c03b05aba3f8884d8eb7adfe3572ad228af972bb60057bdb48450
$(PKG)_SUBDIR   := libpng-$($(PKG)_VERSION)
$(PKG)_FILE     := libpng-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/libpng/libpng16/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/p/libpng/code/ref/master/tags/' | \
    $(SED) -n 's,.*<a[^>]*>v\([0-9][^<]*\)<.*,\1,p' | \
    grep -v alpha | \
    grep -v beta | \
    grep -v rc | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    ln -sf '$(PREFIX)/$(TARGET)/bin/libpng-config' '$(PREFIX)/bin/$(TARGET)-libpng-config'
    '$(TARGET)-gcc' -W -Wall -Werror -std=c99 -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libpng.exe' `'$(PREFIX)/$(TARGET)/bin/libpng-config' --static --cflags --libs`
endef
