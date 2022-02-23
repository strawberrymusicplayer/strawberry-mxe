# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.47.0
$(PKG)_CHECKSUM := db98735b30f1586edf3212ada57f85feaceff483a1c0f1c1c8285abcf37e3444
$(PKG)_GH_CONF  := nghttp2/nghttp2/tags, v
$(PKG)_DEPS     := cc openssl zlib libxml2 cares

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
