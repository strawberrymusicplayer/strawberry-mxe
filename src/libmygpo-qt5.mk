# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libmygpo-qt5
$(PKG)_WEBSITE  := https://github.com/gpodder/libmygpo-qt
$(PKG)_DESCR    := libmygpo Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ba5db4d
$(PKG)_CHECKSUM := 69ed06e061bea6fdcebe461382b9abeaf72b5dddcdab95ec87520c261fed0400
$(PKG)_GH_CONF  := gpodder/libmygpo-qt/branches/master
$(PKG)_DEPS     := cc qt5-qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) -DMYGPO_BUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
