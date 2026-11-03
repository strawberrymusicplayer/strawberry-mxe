# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := rapidjson
$(PKG)_WEBSITE  := https://rapidjson.org/
$(PKG)_DESCR    := A fast JSON parser/generator for C++ with both SAX/DOM style API
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 297637b
$(PKG)_CHECKSUM := 31d3faf312f18926dc60c2b2e408c2e59a70848c01650bf92c534a8bb39b1c26
$(PKG)_GH_CONF  := Tencent/rapidjson/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    CXXFLAGS='-Wno-array-bounds -Wno-stringop-overread' '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_INSTALL_DIR="$(PREFIX)/$(TARGET)/lib/cmake/RapidJSON" \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
