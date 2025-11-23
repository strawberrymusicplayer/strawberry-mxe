# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgme
$(PKG)_WEBSITE  := https://github.com/libgme/game-music-emu
$(PKG)_DESCR    := Collection of video game music file emulators
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.4
$(PKG)_CHECKSUM := f2360feb5a32ace226c583df4faf6eff74145c81264aaea11e17a1af2f6f101a
$(PKG)_GH_CONF  := libgme/game-music-emu/releases/latest
$(PKG)_FILE     := game-music-emu-$($(PKG)_VERSION)-src.tar.gz
$(PKG)_SUBDIR   := game-music-emu-$($(PKG)_VERSION)
$(PKG)_URL      := https://github.com/libgme/game-music-emu/releases/download/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DENABLE_UBSAN=OFF '$(SOURCE_DIR)' \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
