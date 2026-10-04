# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtsparkle-qt6
$(PKG)_WEBSITE  := https://github.com/jonaski/qtsparkle
$(PKG)_DESCR    := Qt 6 auto-update Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1318e5b
$(PKG)_CHECKSUM := ec902e9fcd0a5442992ab6f1a5b574c473153ef35e077ba7e856d448e249193d
$(PKG)_GH_CONF  := jonaski/qtsparkle/branches/master
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
