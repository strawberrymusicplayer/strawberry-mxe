# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := killproc
$(PKG)_WEBSITE  := https://github.com/jonaski/killproc
$(PKG)_DESCR    := KillProc
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 82eec9b
$(PKG)_CHECKSUM := 959e12966a9a718d13b075becc6f846d48bb8a1dbf64780b2a25f7ed309c7ac6
$(PKG)_GH_CONF  := jonaski/killproc/branches/master
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(INSTALL) '$(BUILD_DIR)/killproc.exe' '$(PREFIX)/$(TARGET)/bin'
endef

$(PKG)_BUILD_STATIC =
