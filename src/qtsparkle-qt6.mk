# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtsparkle-qt6
$(PKG)_WEBSITE  := https://github.com/strawberrymusicplayer/qtsparkle
$(PKG)_DESCR    := Qt 6 auto-update Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 173e1e1
$(PKG)_CHECKSUM := 98cb56b1a0e5340b39def28951725696980bd850561e0a70c2ff0c4bcbdc2b5e
$(PKG)_GH_CONF  := strawberrymusicplayer/qtsparkle/branches/master
$(PKG)_DEPS     := cc qt6-qtbase qt6-qttools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DCMAKE_PREFIX_PATH=$(PREFIX)/$(TARGET)/qt6/lib/cmake \
        -DBUILD_WITH_QT6=ON \
        -DQt6_DIR=$(PREFIX)/$(TARGET)/qt6/lib/cmake \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
