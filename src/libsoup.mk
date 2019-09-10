# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.62.3
$(PKG)_CHECKSUM := d312ade547495c2093ff8bda61f9b9727a98cfdae339f3263277dd39c0451172
$(PKG)_SUBDIR   := libsoup-$($(PKG)_VERSION)
$(PKG)_FILE     := libsoup-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/libsoup/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson ninja glib libxml2 sqlite libbrotli libpsl

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/libsoup/-/tags' | \
#    $(SED) -n "s,.*libsoup-\([0-9]\+\.[0-9]*[0-9]*\.[^']*\)\.tar.*,\1,p" | \
#    $(SORT) -Vr | \
#    head -1
#endef

# Compiles but has error - no uri handler implemented
# 2.63.2, 2.64.2 and 2.66.2

# Does not compile
# 2.65.2

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && \
        NOCONFIGURE=1 \
        ACLOCAL_FLAGS=-I'$(PREFIX)/$(TARGET)/share/aclocal' \
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-vala \
        --without-apache-httpd \
        --without-gssapi \
        $(shell [ `uname -s` == Darwin ] && echo "INTLTOOL_PERL=/usr/bin/perl")
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

endef
