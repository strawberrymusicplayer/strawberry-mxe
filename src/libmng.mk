# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libmng
$(PKG)_WEBSITE  := https://www.libmng.com/
$(PKG)_DESCR    := The MNG reference library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.9.1
$(PKG)_CHECKSUM := 
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)-devel/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc jpeg lcms zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/libmng/files/libmng-devel/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    echo 'Requires: zlib lcms2 libjpeg' >> '$(1)/libmng.pc.in'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' LDFLAGS='-no-undefined'
    $(MAKE) -C '$(1)' -j 1 install
endef
