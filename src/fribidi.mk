# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fribidi
$(PKG)_WEBSITE  := https://fribidi.org/
$(PKG)_DESCR    := GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.12
$(PKG)_CHECKSUM := 2e9e859876571f03567ac91e5ed3b5308791f31cda083408c2b60fa1fe00a39d
$(PKG)_GH_CONF  := fribidi/fribidi/releases, v
$(PKG)_DEPS     := cc meson-conf $(BUILD)~ninja

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Ddocs=false -Ddeprecated=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
