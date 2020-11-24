# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gstreamer
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/gstreamer.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7c0dcb9
$(PKG)_CHECKSUM := 4f11497ff9259dfc90fa442ec1bf264ba078755adab570b1cbf955e2668f1cbe
$(PKG)_GH_CONF  := gstreamer/gstreamer/branches/master
$(PKG)_SUBDIR   := GStreamer-gstreamer-$($(PKG)_VERSION)
$(PKG)_DEPS     := cc glib libxml2 pthreads orc

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://cgit.freedesktop.org/gstreamer/gstreamer/refs/tags' | \
#    $(SED) -n "s,.*<a href='[^']*/tag/?h=[^0-9]*\\([0-9]\..[02468]\.[0-9][^']*\\)'.*,\\1,p" | \
#    $(SORT) -Vr | \
#    head -1
#endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)' -Dexamples=disabled -Dtests=disabled -Dgtk_doc=disabled
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    # some .dlls are installed to lib - no obvious way to change
    $(if $(BUILD_SHARED),
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0'
        mv -vf '$(PREFIX)/$(TARGET)/lib/gstreamer-1.0/'*.dll '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/'
    )

endef
