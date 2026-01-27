# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gstreamer
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gstreamer.html
$(PKG)_DESCR    := Open Source Multimedia Framework
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.28.0
$(PKG)_CHECKSUM := 6c8676bc39a2b41084fd4b21d2c37985c69ac979c03ce59575db945a3a623afd
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib pthreads orc dlfcn-win32

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gstreamer.freedesktop.org/src/gstreamer' | \
    $(SED) -n "s,.*gstreamer-\([0-9]\.[0-9][02468]\.[0-9]*\)\.tar\.xz.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dexamples=disabled \
        -Dtests=disabled \
        -Dbenchmarks=disabled \
        -Dtools=enabled \
        -Dintrospection=disabled \
        -Dnls=enabled \
        -Ddoc=disabled \
        -Dgst_debug=true \
        -Dgst_parse=true \
        -Dregistry=true \
        '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )

endef
