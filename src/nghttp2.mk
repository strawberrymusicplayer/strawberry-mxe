# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.49.0
$(PKG)_CHECKSUM := 744f38f8d6e400a424bf62df449c91e3ffacbae11b5fab99e44a480f5c735ab9
$(PKG)_GH_CONF  := nghttp2/nghttp2/tags, v
$(PKG)_DEPS     := cc openssl zlib libxml2 cares

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
