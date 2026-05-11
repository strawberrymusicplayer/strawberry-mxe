# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib Audio Meta-Data Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.3
$(PKG)_CHECKSUM := 7349f6fd942418bc7009ebe743eb7c9d055f02921ec56fa436ec25007c47fd38
$(PKG)_GH_CONF  := taglib/taglib/releases/latest, v
$(PKG)_DEPS     := cc zlib utfcpp

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
