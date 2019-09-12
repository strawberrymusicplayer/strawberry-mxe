# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := popt
$(PKG)_WEBSITE  := http://freshmeat.net/projects/popt/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.16
$(PKG)_CHECKSUM := e728ed296fe9f069a0e005003c3d6b2dde3d9cad453422a10d6558616d304cc8
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://anduin.linuxfromscratch.org/BLFS/popt/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gettext libiconv

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://anduin.linuxfromscratch.org/BLFS/popt/' | \
    grep 'popt-' | \
    $(SED) -n 's,.*popt-\([0-9][^>]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-nls
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
