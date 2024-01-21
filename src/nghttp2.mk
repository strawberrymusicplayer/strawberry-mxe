# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.59.0
$(PKG)_CHECKSUM := 90fd27685120404544e96a60ed40398a3457102840c38e7215dc6dec8684470f
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
