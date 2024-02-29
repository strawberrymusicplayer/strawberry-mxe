# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := expat
$(PKG)_WEBSITE  := https://libexpat.github.io/
$(PKG)_DESCR    := a stream-oriented XML parser library written in C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.6.1
$(PKG)_CHECKSUM := 4677d957c0c6cb2a3321101944574c24113b637c7ab1cf0659a27c5babc201fd
$(PKG)_SUBDIR   := expat-$($(PKG)_VERSION)
$(PKG)_FILE     := expat-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/expat/expat/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/expat/files/expat/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --without-examples --without-tests --without-docbook
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
