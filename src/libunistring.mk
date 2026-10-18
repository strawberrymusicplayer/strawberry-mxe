# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libunistring
$(PKG)_WEBSITE  := https://www.gnu.org/software/libunistring/
$(PKG)_DESCR    := libunistring
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5
$(PKG)_CHECKSUM := fe89007a8a414ae4790b816b86859e877d3ab135db3c37f06541ff7e85ac344b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gnuftp.uib.no/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libiconv

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gnuftp.uib.no/libunistring/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="libunistring-\([0-9][^"]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -f
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-rpath --enable-relocatable --enable-threads=$(MXE_GCC_THREADS)
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
