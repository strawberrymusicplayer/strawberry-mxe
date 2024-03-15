# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := expat
$(PKG)_WEBSITE  := https://libexpat.github.io/
$(PKG)_DESCR    := a stream-oriented XML parser library written in C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.6.2
$(PKG)_CHECKSUM := ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364
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
