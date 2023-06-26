# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libebur128
$(PKG)_WEBSITE  := https://github.com/jiixyj/libebur128
$(PKG)_DESCR    := libebur128 is a library that implements the EBU R 128 standard for loudness normalisation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.6
$(PKG)_CHECKSUM := baa7fc293a3d4651e244d8022ad03ab797ca3c2ad8442c43199afe8059faa613
$(PKG)_GH_CONF  := jiixyj/libebur128/releases/latest, v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
