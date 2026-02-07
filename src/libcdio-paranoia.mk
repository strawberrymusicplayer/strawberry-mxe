# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcdio-paranoia
$(PKG)_WEBSITE  := https://www.gnu.org/software/libcdio/
$(PKG)_DESCR    := CD paranoia library from libcdio
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.2+2.0.2
$(PKG)_CHECKSUM := 186892539dedd661276014d71318c8c8f97ecb1250a86625256abd4defbf0d0c
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_URL      := https://gnuftp.uib.no/libcdio/$(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_DEPS     := cc libcdio

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gnuftp.uib.no/libcdio/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="libcdio-paranoia-\([0-9][^"]*\)\.tar.bz2.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j 1 install
endef
