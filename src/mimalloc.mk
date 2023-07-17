# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mimalloc
$(PKG)_WEBSITE  := https://github.com/microsoft/mimalloc
$(PKG)_DESCR    := mimalloc
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.2
$(PKG)_CHECKSUM := 2b1bff6f717f9725c70bf8d79e4786da13de8a270059e4ba0bdd262ae7be46eb
$(PKG)_GH_CONF  := microsoft/mimalloc/tags/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DMI_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DMI_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        -DMI_BUILD_TESTS=OFF \
        -DMI_CHECK_FULL=OFF \
        -DMI_DEBUG_FULL=OFF \
        -DMI_DEBUG_TSAN=OFF \
        -DMI_DEBUG_UBSAN=OFF \
        -DMI_OVERRIDE=ON \
        -DMI_USE_CXX=ON \
        -DMI_WIN_REDIRECT=ON
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
