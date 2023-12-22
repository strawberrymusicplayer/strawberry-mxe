# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := kdsingleapplication
$(PKG)_WEBSITE  := https://github.com/KDAB/KDSingleApplication
$(PKG)_DESCR    := KDAB's helper class for single-instance policy applications
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.0
$(PKG)_CHECKSUM := 31029fffa4873e2769c555668e8edaa6bd5721edbc445bff5e66cc6af3b9ed78
$(PKG)_GH_CONF  := KDAB/KDSingleApplication/releases/latest, v
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_DEPS     := cc qt6-qtbase

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DKDSingleApplication_QT6=ON
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
