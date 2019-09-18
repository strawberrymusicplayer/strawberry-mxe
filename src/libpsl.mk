# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libpsl
$(PKG)_WEBSITE  := http://www.linuxfromscratch.org/blfs/view/svn/basicnet/libpsl.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.21.0
$(PKG)_CHECKSUM := 41bd1c75a375b85c337b59783f5deb93dbb443fb0a52d257f403df7bd653ee12
$(PKG)_GH_CONF  := rockdaboot/libpsl/tags, libpsl-
$(PKG)_SUBDIR   := libpsl-$($(PKG)_VERSION)
$(PKG)_FILE     := libpsl-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/rockdaboot/libpsl/releases/download/$(PKG)-$($(PKG)_VERSION)/$(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
