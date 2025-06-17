# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.66.0
$(PKG)_CHECKSUM := e178687730c207f3a659730096df192b52d3752786c068b8e5ee7aeb8edae05a
$(PKG)_GH_CONF  := nghttp2/nghttp2/releases/latest, v
$(PKG)_DEPS     := cc openssl zlib libxml2 cares

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/lib/libnghttp2.dll.a'),)
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/bin/libnghttp2.dll'),)
endef
