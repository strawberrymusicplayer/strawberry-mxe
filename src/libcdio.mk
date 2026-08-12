# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcdio
$(PKG)_WEBSITE  := https://www.gnu.org/software/libcdio/
$(PKG)_DESCR    := GNU Compact Disc Input and Control Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.0
$(PKG)_CHECKSUM := bf7cde63762bb12db7755c395c441e49406fde7e1d9f9a9be7e3b940b1f405d7
$(PKG)_GH_CONF  := libcdio/libcdio/releases/latest
$(PKG)_DEPS     := cc getopt-win

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) \
        --disable-silent-rules \
        --disable-rpath \
        --without-cd-drive \
        --without-cd-info \
        --without-cd-read \
        --without-cdda-player \
        --without-iso-info \
        --without-iso-read \
        --enable-rock \
        LDFLAGS='$(LDFLAGS) -lgetopt'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
