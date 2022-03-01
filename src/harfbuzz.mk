# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := harfbuzz
$(PKG)_WEBSITE  := https://wiki.freedesktop.org/www/Software/HarfBuzz/
$(PKG)_DESCR    := HarfBuzz is a text shaping engine
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.0
$(PKG)_CHECKSUM := 4880c25022100c31aef4bdea084be2fe58020f9756e94151b8d1cbf0be1ed54c
$(PKG)_GH_CONF  := harfbuzz/harfbuzz/releases
$(PKG)_DEPS     := cc cairo freetype-bootstrap glib icu4c

define $(PKG)_BUILD
    # mman-win32 is only a partial implementation
    cd '$(1)' && ./autogen.sh && ./configure $(MXE_CONFIGURE_OPTS) ac_cv_header_sys_mman_h=no
    $(MAKE) -C '$(1)'
    $(MAKE) -C '$(1)' install
endef
