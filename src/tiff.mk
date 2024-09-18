# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := tiff
$(PKG)_WEBSITE  := http://simplesystems.org/libtiff/
$(PKG)_DESCR    := TIFF Library and Utilities
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.7.0
$(PKG)_CHECKSUM := 67160e3457365ab96c5b3286a0903aa6e78bdc44c4bc737d2e486bcecb6ba976
$(PKG)_SUBDIR   := tiff-$($(PKG)_VERSION)
$(PKG)_FILE     := tiff-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://download.osgeo.org/libtiff/$($(PKG)_FILE)
$(PKG)_DEPS     := cc jpeg libwebp xz zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://simplesystems.org/libtiff/' | \
    $(SED) -n 's,.*>v\([0-9][^<]*\)<.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-rpath --without-x
    $(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_CRUFT)
endef
