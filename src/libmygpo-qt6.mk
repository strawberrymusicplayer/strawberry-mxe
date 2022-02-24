# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libmygpo-qt6
$(PKG)_WEBSITE  := https://github.com/gpodder/libmygpo-qt
$(PKG)_DESCR    := libmygpo Qt 6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := b0260e6
$(PKG)_CHECKSUM := 48f5a8297c5afa7dabe7c7261403a3cc097a0613039bac4d5cc280f44a8ee4b7
$(PKG)_GH_CONF  := gpodder/libmygpo-qt/branches/master
$(PKG)_DEPS     := cc qt6-qtbase qt6-qttools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DCMAKE_PREFIX_PATH=$(PREFIX)/$(TARGET)/qt6/lib/cmake \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DMYGPO_BUILD_TESTS=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
