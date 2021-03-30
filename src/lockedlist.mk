# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lockedlist
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/LockedList_plug-in
$(PKG)_DESCR    := LockedList NSIS Plugin
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0
$(PKG)_CHECKSUM := 4de20f933325cdefaa93653b0be736db5ae35e97d4173c16dbcd2b073c916da8
$(PKG)_FILE     := LockedList.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/d/d3/LockedList.zip
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(INSTALL) '$(SOURCE_DIR)/Plugins/x86-unicode/LockedList.dll' '$(PREFIX)/$(TARGET)/bin'
    $(INSTALL) '$(SOURCE_DIR)/Plugins/LockedList64.dll' '$(PREFIX)/$(TARGET)/bin'
endef

$(PKG)_BUILD_STATIC =
