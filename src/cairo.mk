# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cairo
$(PKG)_WEBSITE  := https://cairographics.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.15.12
$(PKG)_CHECKSUM := 7623081b94548a47ee6839a7312af34e9322997806948b6eec421a8c6d0594c9
$(PKG)_SUBDIR   := cairo-$($(PKG)_VERSION)
$(PKG)_FILE     := cairo-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://cairographics.org/snapshots/$($(PKG)_FILE)
$(PKG)_DEPS     := cc fontconfig freetype-bootstrap glib libpng lzo pixman zlib

define $(PKG)_UPDATE
    echo 'TODO: Updates for package $(PKG) need to be written.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://cairographics.org/releases/?C=M;O=D' | \
#    $(SED) -n 's,.*"cairo-\([0-9][^"]*\)\.tar.*,\1,p' | \
#    head -1
#endef

define $(PKG)_BUILD
    $(SED) -i 's,libpng12,libpng,g'                          '$(1)/configure'
    $(SED) -i 's,^\(Libs:.*\),\1 @CAIRO_NONPKGCONFIG_LIBS@,' '$(1)/src/cairo.pc.in'
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-lto \
        --disable-gtk-doc \
        --disable-test-surfaces \
        --disable-gcov \
        --disable-xlib \
        --disable-xlib-xrender \
        --disable-xcb \
        --disable-quartz \
        --disable-quartz-font \
        --disable-quartz-image \
        --disable-os2 \
        --disable-beos \
        --disable-directfb \
        --disable-atomic \
        --enable-win32 \
        --enable-win32-font \
        --enable-png \
        --enable-ft \
        --enable-ps \
        --enable-pdf \
        --enable-svg \
        --disable-pthread \
        CFLAGS="$(CFLAGS) $(if $(BUILD_STATIC),-DCAIRO_WIN32_STATIC_BUILD)" \
        LIBS="-lmsimg32 -lgdi32 `$(TARGET)-pkg-config pixman-1 --libs`"
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
