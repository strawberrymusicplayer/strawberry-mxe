# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fontconfig
$(PKG)_WEBSITE  := https://fontconfig.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.13.91
$(PKG)_CHECKSUM := 0130cff91dabe4909b0ea246accf8fa69af8de2771772f1c9ec11a5834e1e501
$(PKG)_SUBDIR   := fontconfig-$($(PKG)_VERSION)
$(PKG)_FILE     := fontconfig-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://fontconfig.org/release/$($(PKG)_FILE)
$(PKG)_DEPS     := cc expat freetype-bootstrap gettext

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://fontconfig.org/release/' | \
    $(SED) -n 's,.*fontconfig-\([0-9][^>]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-arch='$(TARGET)' \
        --with-expat='$(PREFIX)/$(TARGET)' \
        --disable-docs
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
