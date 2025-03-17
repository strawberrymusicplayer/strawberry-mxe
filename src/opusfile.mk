# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := opusfile
$(PKG)_WEBSITE  := https://opus-codec.org/
$(PKG)_DESCR    := Opus Interactive Audio Codec
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.12
$(PKG)_CHECKSUM := 118d8601c12dd6a44f52423e68ca9083cc9f2bfe72da7a8c1acb22a80ae3550b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ftp.osuosl.org/pub/xiph/releases/opus/$($(PKG)_FILE)
$(PKG)_URL2     := https://github.com/xiph/opusfile/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_GH_CONF  := xiph/opusfile/releases/latest, v
$(PKG)_DEPS     := cc libogg libopus

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-doc --disable-examples --disable-http
    $(MAKE) -C '$(1)' -j '$(JOBS)' noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install noinst_PROGRAMS=
endef
