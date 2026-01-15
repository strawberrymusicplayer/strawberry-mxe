# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libopus
$(PKG)_WEBSITE  := https://opus-codec.org/
$(PKG)_DESCR    := Opus Interactive Audio Codec
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.1
$(PKG)_CHECKSUM := 6ffcb593207be92584df15b32466ed64bbec99109f007c82205f0194572411a1
$(PKG)_SUBDIR   := opus-$($(PKG)_VERSION)
$(PKG)_FILE     := opus-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://downloads.xiph.org/releases/opus/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://downloads.xiph.org/releases/opus/?C=M;O=D' | \
    $(SED) -n 's,.*opus-\([0-9][^>]*\)\.tar.*,\1,p' | \
    grep -v 'alpha' | \
    grep -v 'beta' | \
    grep -v 'rc' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && $(SHELL) ./configure $(MXE_CONFIGURE_OPTS) --disable-doc
    $(MAKE) -C '$(1)' -j '$(JOBS)' SHELL=$(SHELL) $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(1)' -j 1 install SHELL=$(SHELL) $(MXE_DISABLE_CRUFT)
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/opus_*.3
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/opus.h.3
    rm -rf '$(PREFIX)/$(TARGET)'/share/doc/opus/html
endef
