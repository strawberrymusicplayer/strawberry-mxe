# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpg123
$(PKG)_WEBSITE  := https://www.mpg123.de/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.32.0
$(PKG)_CHECKSUM := 23d4629e30a59a6b0e05b39283f78b8e261e70e9c2673b3c1179718b393aec01
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/mpg123/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/mpg123/files/mpg123/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-default-audio=win32 \
        --with-audio=win32,win32_wasapi,dummy \
        --enable-modules=no
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
