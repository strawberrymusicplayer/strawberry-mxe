# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := wavpack
$(PKG)_WEBSITE  := http://www.wavpack.com/
$(PKG)_DESCR    := WavPack - Hybrid Lossless Audio Compression
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.4.0
$(PKG)_CHECKSUM := 0716a6dcf9a72d61005e1b09bbbd61aaf49837cb4e4a351992a6daed16cac034
$(PKG)_SUBDIR   := wavpack-$($(PKG)_VERSION)
$(PKG)_FILE     := wavpack-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.wavpack.com/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://www.wavpack.com/downloads.html' | \
    grep '<a href="wavpack-.*\.tar\.bz2">' | \
    head -n 1 | \
    $(SED) -e 's/^.*<a href="wavpack-\([0-9.]*\)\.tar\.bz2">.*$$/\1/'
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-rpath --disable-tests --disable-apps --without-iconv CFLAGS="$(CFLAGS) -DWIN32"
    $(MAKE) -C '$(1)' -j '$(JOBS)' SUBDIRS="src include"
    $(MAKE) -C '$(1)' -j 1 install SUBDIRS="src include"
endef
