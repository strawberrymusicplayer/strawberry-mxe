# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faac
$(PKG)_WEBSITE  := https://www.audiocoding.com/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.30
$(PKG)_CHECKSUM := adc387ce588cca16d98c03b6ec1e58f0ffd9fc6eadb00e254157d6b16203b2d2
$(PKG)_SUBDIR   := $(PKG)-$(subst .,_,$($(PKG)_VERSION))
$(PKG)_FILE     := $(PKG)-$(subst .,_,$($(PKG)_VERSION)).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/faac/$(PKG)-src/$(PKG)-1.30/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/faac/files/faac-src/faac-1.30/' | \
    $(SED) -n 's,.*faac-\([0-9][^"]*\).tar.gz".*,\1,p' | \
    $(SED) 's,_,.,g' |
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && libtoolize --force
    cd '$(1)' && aclocal
    cd '$(1)' && autoheader
    cd '$(1)' && automake --force-missing --add-missing
    cd '$(1)' && autoconf
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' LDFLAGS='-no-undefined'
    $(MAKE) -C '$(1)' -j 1 install LDFLAGS='-no-undefined'
endef
