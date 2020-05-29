# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fribidi
$(PKG)_WEBSITE  := https://fribidi.org/
$(PKG)_DESCR    := FriBidi
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.9
$(PKG)_CHECKSUM := ef6f940d04213a0fb91a0177b2b57df2031bf3a7e2cd0ee2c6877a160fc206df
$(PKG)_GH_CONF  := fribidi/fribidi/releases, v
$(PKG)_DEPS     := cc meson-conf ninja $(BUILD)~meson

$(PKG)_DEPS_$(BUILD) := meson ninja

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(TARGET)-meson '$(BUILD_DIR)' -Ddocs=false -Ddeprecated=false
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
