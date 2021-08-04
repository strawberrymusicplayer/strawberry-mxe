# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libmygpo-qt5
$(PKG)_WEBSITE  := https://github.com/gpodder/libmygpo-qt
$(PKG)_DESCR    := libmygpo Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := b1120ec
$(PKG)_CHECKSUM := 47c9b250d9f7fbd0453ee90d06c66773522753b6c3740f836a3e7d215224a6c9
$(PKG)_GH_CONF  := gpodder/libmygpo-qt/branches/master
$(PKG)_DEPS     := cc qt5-qtbase qt5-qttools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) -DMYGPO_BUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
