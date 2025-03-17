# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libopus
$(PKG)_WEBSITE  := https://opus-codec.org/
$(PKG)_DESCR    := Opus Interactive Audio Codec
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.2
$(PKG)_CHECKSUM := 65c1d2f78b9f2fb20082c38cbe47c951ad5839345876e46941612ee87f9a7ce1
$(PKG)_SUBDIR   := opus-$($(PKG)_VERSION)
$(PKG)_FILE     := opus-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://downloads.xiph.org/releases/opus/$($(PKG)_FILE)
$(PKG)_URL_2    := https://github.com/xiph/opus/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_GH_CONF  := xiph/opus/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(1)' && $(SHELL) ./configure $(MXE_CONFIGURE_OPTS) --disable-doc
    $(MAKE) -C '$(1)' -j '$(JOBS)' SHELL=$(SHELL) $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(1)' -j 1 install SHELL=$(SHELL) $(MXE_DISABLE_CRUFT)
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/opus_*.3
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/opus.h.3
    rm -rf '$(PREFIX)/$(TARGET)'/share/doc/opus/html
endef
