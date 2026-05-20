# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := utfcpp
$(PKG)_WEBSITE  := https://github.com/nemtrif/utfcpp
$(PKG)_DESCR    := UTF-8 with C++ in a Portable Way
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.1
$(PKG)_CHECKSUM := 1ca68016f0abc24172998e39ce0d8f8e2b7a26f7579a0ff85d4e1b9a7aea56f8
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
