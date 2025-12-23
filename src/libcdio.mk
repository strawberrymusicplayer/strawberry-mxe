# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcdio
$(PKG)_WEBSITE  := https://www.gnu.org/software/libcdio/
$(PKG)_DESCR    := GNU Compact Disc Input and Control Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.3.0
$(PKG)_CHECKSUM := 37bcb13296febbcff9dc4485834bac09212cb463c31fcea52f70ee1dd3a5a5de
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
