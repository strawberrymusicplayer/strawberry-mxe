# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libxml2
$(PKG)_WEBSITE  := http://www.xmlsoft.org/
$(PKG)_DESCR    := The XML C parser and toolkit of Gnome
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.13.0
$(PKG)_CHECKSUM := d5a2f36bea96e1fb8297c6046fb02016c152d81ed58e65f3d20477de85291bc9
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc xz zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/libxml2/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\([0-9,\.]\+\)<.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    $(SED) -i 's,`uname`,MinGW,g' '$(1)/xml2-config.in'
    cd '$(1)' && ./autogen.sh
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --with-zlib='$(PREFIX)/$(TARGET)/lib' --without-debug --without-python --with-threads=$(MXE_GCC_THREADS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    ln -sf '$(PREFIX)/$(TARGET)/bin/xml2-config' '$(PREFIX)/bin/$(TARGET)-xml2-config'
endef
