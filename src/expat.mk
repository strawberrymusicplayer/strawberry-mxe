# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := expat
$(PKG)_WEBSITE  := https://libexpat.github.io/
$(PKG)_DESCR    := a stream-oriented XML parser library written in C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.7.4
$(PKG)_CHECKSUM := 9e9cabb457c1e09de91db2706d8365645792638eb3be1f94dbb2149301086ac0
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
