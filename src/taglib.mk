# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 79bc9cc
$(PKG)_CHECKSUM := e029a6f12d5a623e7e5d497a0c76a6d28af67f97a4f611e0c0ef5952b25eb925
$(PKG)_GH_CONF  := taglib/taglib/branches/master
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
