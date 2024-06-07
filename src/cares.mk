# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cares
$(PKG)_WEBSITE  := https://c-ares.org/
$(PKG)_DESCR    := c-ares is a C library for asynchronous DNS requests
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.29.0
$(PKG)_CHECKSUM := 0b89fa425b825c4c7bc708494f374ae69340e4d1fdc64523bdbb2750bfc02ea7
$(PKG)_FILE     := c-ares-$($(PKG)_VERSION).tar.gz
$(PKG)_SUBDIR   := c-ares-$($(PKG)_VERSION)
$(PKG)_URL      := https://github.com/c-ares/c-ares/releases/download/cares-$(subst .,_,$($(PKG)_VERSION))/$($(PKG)_FILE)
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
