# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := orc
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/projects/orc.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.31
$(PKG)_CHECKSUM := a0ab5f10a6a9ae7c3a6b4218246564c3bf00d657cbdf587e6d34ec3ef0616075
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf $(BUILD)~meson

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://cgit.freedesktop.org/gstreamer/orc/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?h=[^0-9]*\\([0-9]*\.[0-9]*\.[0-9][^']*\\)'.*,\\1,p" | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
