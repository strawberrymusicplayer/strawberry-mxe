# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := rapidjson
$(PKG)_WEBSITE  := https://rapidjson.org/
$(PKG)_DESCR    := A fast JSON parser/generator for C++ with both SAX/DOM style API
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 24b5e7a
$(PKG)_CHECKSUM := e21cddc53c3cfe4063d4d57c0588e969398af51c42ac9d52af3442795f07cc6f
$(PKG)_GH_CONF  := Tencent/rapidjson/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    CXXFLAGS='-Wno-array-bounds -Wno-stringop-overread' '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
