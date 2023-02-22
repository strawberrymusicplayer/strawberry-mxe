# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := sqlite
$(PKG)_WEBSITE  := https://www.sqlite.org/
$(PKG)_DESCR    := SQLite database engine
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3410000
$(PKG)_CHECKSUM := 49f77ac53fd9aa5d7395f2499cb816410e5621984a121b858ccca05310b05c70
$(PKG)_SUBDIR   := $(PKG)-autoconf-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-autoconf-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.sqlite.org/2023/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.sqlite.org/download.html' | \
    $(SED) -n 's,.*sqlite-autoconf-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-readline --enable-threadsafe CFLAGS="-Os -DSQLITE_ENABLE_COLUMN_METADATA"
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
