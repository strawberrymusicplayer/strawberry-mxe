# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib Audio Meta-Data Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.13
$(PKG)_CHECKSUM := 58f08b4db3dc31ed152c04896ee9172d22052bc7ef12888028c01d8b1d60ade0
$(PKG)_GH_CONF  := taglib/taglib/releases/latest, v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
