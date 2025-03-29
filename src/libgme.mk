# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgme
$(PKG)_WEBSITE  := https://bitbucket.org/mpyne/game-music-emu/
$(PKG)_DESCR    := Collection of video game music file emulators
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.3
$(PKG)_CHECKSUM := aba34e53ef0ec6a34b58b84e28bf8cfbccee6585cebca25333604c35db3e051d
$(PKG)_FILE     := game-music-emu-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := game-music-emu-$($(PKG)_VERSION)
$(PKG)_URL      := https://bitbucket.org/mpyne/game-music-emu/downloads/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://bitbucket.org/mpyne/game-music-emu/downloads/' | \
    $(SED) -n 's,.*game-music-emu-\([^>]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

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
