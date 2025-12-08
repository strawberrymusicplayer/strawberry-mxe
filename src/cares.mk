# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cares
$(PKG)_WEBSITE  := https://c-ares.org/
$(PKG)_DESCR    := c-ares is a C library for asynchronous DNS requests
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.34.6
$(PKG)_CHECKSUM := 912dd7cc3b3e8a79c52fd7fb9c0f4ecf0aaa73e45efda880266a2d6e26b84ef5
$(PKG)_FILE     := c-ares-$($(PKG)_VERSION).tar.gz
$(PKG)_SUBDIR   := c-ares-$($(PKG)_VERSION)
$(PKG)_URL      := https://github.com/c-ares/c-ares/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
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
