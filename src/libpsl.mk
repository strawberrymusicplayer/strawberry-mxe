# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libpsl
$(PKG)_WEBSITE  := http://www.linuxfromscratch.org/blfs/view/svn/basicnet/libpsl.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.21.1
$(PKG)_CHECKSUM := ac6ce1e1fbd4d0254c4ddb9d37f1fa99dec83619c1253328155206b896210d4c
$(PKG)_GH_CONF  := rockdaboot/libpsl/releases/latest
$(PKG)_SUBDIR   := libpsl-$($(PKG)_VERSION)
$(PKG)_FILE     := libpsl-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/rockdaboot/libpsl/releases/download/$($(PKG)_VERSION)/$(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc libunistring

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
