# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-registry
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/Registry_plug-in
$(PKG)_DESCR    := NSIS Registry Plugin
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2
$(PKG)_CHECKSUM := 791451f1be34ea1ed6f2ad6d205cf8e54bb0562af11b0160a6bfa5f499624094
$(PKG)_FILE     := Registry.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/4/47/Registry.zip
$(PKG)_DEPS     := cc nsis

define $(PKG)_BUILD
    $(INSTALL) '$(SOURCE_DIR)/Desktop/Plugin/registry.dll' '$(PREFIX)/$(TARGET)/share/nsis/Plugins'
endef

$(PKG)_BUILD_STATIC =
