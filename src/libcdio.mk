# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcdio
$(PKG)_WEBSITE  := https://www.gnu.org/software/libcdio/
$(PKG)_DESCR    := GNU Compact Disc Input and Control Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.2.0
$(PKG)_CHECKSUM := 1b6c58137f71721ddb78773432d26252ee6500d92d227d4c4892631c30ea7abb
$(PKG)_GH_CONF  := libcdio/libcdio/releases/latest
$(PKG)_DEPS     := cc

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
        --enable-rock
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
