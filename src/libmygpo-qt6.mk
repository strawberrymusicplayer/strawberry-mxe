# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libmygpo-qt6
$(PKG)_WEBSITE  := https://github.com/gpodder/libmygpo-qt
$(PKG)_DESCR    := libmygpo Qt 6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 21e18a7
$(PKG)_CHECKSUM := de69ee4c9ef17f031d9d6a91b2496ada79cc5886e4d64eea808890ee345cf018
$(PKG)_GH_CONF  := gpodder/libmygpo-qt/branches/master
$(PKG)_DEPS     := cc qt6-qtbase qt6-qttools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) -DCMAKE_PREFIX_PATH=$(PREFIX)/$(TARGET)/qt6/lib/cmake -DMYGPO_BUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
