# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pango
$(PKG)_WEBSITE  := https://www.pango.org/
$(PKG)_DESCR    := Pango
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.42.4
$(PKG)_CHECKSUM := 1d2b74cd63e8bd41961f2f8d952355aa0f9be6002b52c8aa7699d9f5da597c9d
$(PKG)_SUBDIR   := pango-$($(PKG)_VERSION)
$(PKG)_FILE     := pango-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc cairo fontconfig freetype glib harfbuzz fribidi

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/pango/tags' | \
#    $(SED) -n "s,.*pango-\([0-9]\+\.[0-9]*[02468]\.[^']*\)\.tar.*,\1,p" | \
#    $(SORT) -Vr | \
#    head -1
#endef

define $(PKG)_BUILD
    cd '$(1)' && NOCONFIGURE=1 ./autogen.sh
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-explicit-deps \
        --with-included-modules \
        --without-dynamic-modules \
        --disable-doc-cross-references \
        CXX='$(TARGET)-g++'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
