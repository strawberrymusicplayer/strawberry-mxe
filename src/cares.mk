# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cares
$(PKG)_WEBSITE  := https://c-ares.org/
$(PKG)_DESCR    := c-ares is a C library for asynchronous DNS requests
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.22.1
$(PKG)_CHECKSUM := f67c180deb799c670d9dda995a18ce06f6c7320b6c6363ff8fa85b77d0da9db8
$(PKG)_FILE     := c-ares-$($(PKG)_VERSION).tar.gz
$(PKG)_SUBDIR   := c-ares-$($(PKG)_VERSION)
$(PKG)_URL      := https://c-ares.org/download/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://c-ares.org/download/' | \
    $(SED) -n 's,.*c-ares-\([^>]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-tests --enable-nonblocking
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
