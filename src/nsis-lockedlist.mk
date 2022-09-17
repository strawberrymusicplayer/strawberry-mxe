# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-lockedlist
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/LockedList_plug-in
$(PKG)_DESCR    := NSIS LockedList Plugin
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0
$(PKG)_CHECKSUM := 4de20f933325cdefaa93653b0be736db5ae35e97d4173c16dbcd2b073c916da8
$(PKG)_FILE     := LockedList.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/d/d3/LockedList.zip
$(PKG)_DEPS     := cc nsis

define $(PKG)_BUILD
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/share/nsis/Plugins/x86-unicode'
    $(INSTALL) '$(SOURCE_DIR)/Plugins/x86-unicode/LockedList.dll' '$(PREFIX)/$(TARGET)/share/nsis/Plugins/x86-unicode'
    $(INSTALL) '$(SOURCE_DIR)/Plugins/LockedList64.dll' '$(PREFIX)/$(TARGET)/share/nsis/Plugins'
endef

$(PKG)_BUILD_STATIC =
