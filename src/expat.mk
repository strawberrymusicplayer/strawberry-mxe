# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := expat
$(PKG)_WEBSITE  := https://libexpat.github.io/
$(PKG)_DESCR    := a stream-oriented XML parser library written in C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.8.4
$(PKG)_CHECKSUM := 656ae1cc8da3b4ea513bb4e254f33e6243938084c0ec6239da873376b09985a7
$(PKG)_SUBDIR   := expat-$($(PKG)_VERSION)
$(PKG)_FILE     := expat-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$($(PKG)_VERSION))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://github.com/libexpat/libexpat/releases' | \
    $(SED) -n 's,.*releases/tag/\([^"&;]*\)".*,\1,p' | \
    grep -v '^\*name' | \
    $(SED) 's,^R_,,g' | \
    tr '_' '.' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --without-examples --without-tests --without-docbook
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
