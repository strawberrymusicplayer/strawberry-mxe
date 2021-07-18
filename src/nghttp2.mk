# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nghttp2
$(PKG)_WEBSITE  := https://nghttp2.org/
$(PKG)_DESCR    := HTTP/2 C Library and tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.44.0
$(PKG)_CHECKSUM := 99b90dec8fd2e855bfc69526a8c5f251e788d256a0c9d156c2d0e3279bdd5eed
$(PKG)_GH_CONF  := nghttp2/nghttp2/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
