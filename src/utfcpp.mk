# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := utfcpp
$(PKG)_WEBSITE  := https://github.com/nemtrif/utfcpp
$(PKG)_DESCR    := UTF-8 with C++ in a Portable Way
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.6
$(PKG)_CHECKSUM := 6920a6a5d6a04b9a89b2a89af7132f8acefd46e0c2a7b190350539e9213816c0
$(PKG)_GH_CONF  := nemtrif/utfcpp/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
