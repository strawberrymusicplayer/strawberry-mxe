# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := isl
$(PKG)_WEBSITE  := https://libisl.sourceforge.io/
$(PKG)_DESCR    := Integer Set Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.27
$(PKG)_CHECKSUM := 626335529331f7c89fec493de929e2e92fb3d8cc860fc7af554e0518ee0029ee
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://libisl.sourceforge.io/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc gmp

$(PKG)_DEPS_$(BUILD) := gmp

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://libisl.sourceforge.io/' | \
    $(SED) -n 's,.*isl-\([0-9][^>]*\)\.tar.*,\1,p' | \
    $(SORT) -V |
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --with-gmp-prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' $(if $(BUILD_SHARED), LDFLAGS=-no-undefined)
    $(MAKE) -C '$(1)' -j 1 install
endef
