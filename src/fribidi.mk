# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fribidi
$(PKG)_WEBSITE  := https://fribidi.org/
$(PKG)_DESCR    := GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.14
$(PKG)_CHECKSUM := 7b1b3837f6583432068c71ca333a8988c803e9b94259edbd37c85367bbc51446
$(PKG)_GH_CONF  := fribidi/fribidi/releases, v
$(PKG)_DEPS     := cc meson-conf $(BUILD)~ninja

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && '$(TARGET)-meson' --buildtype='$(MESON_BUILD_TYPE)' -Ddocs=false -Ddeprecated=false '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install
endef
