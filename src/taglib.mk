# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ba7adc2
$(PKG)_CHECKSUM := 3e8a4179afec0c97712a70ac84d67fac59e1421d463d83719671b4dcfe850349
$(PKG)_GH_CONF  := taglib/taglib/branches/master
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
