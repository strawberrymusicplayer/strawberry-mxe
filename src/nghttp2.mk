# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.43.0
$(PKG)_CHECKSUM := f4a9be08d22f5ad9b4bf36c491f1be58e54dc35a1592eaf4e3f79567e4894d0c
$(PKG)_GH_CONF  := nghttp2/nghttp2/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
