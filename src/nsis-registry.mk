# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-registry
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/Registry_plug-in
$(PKG)_DESCR    := NSIS Registry Plugin
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1
$(PKG)_CHECKSUM := 8951a152e1b6addbe2fee953795a992625e860d893b22f928cbf2750c66d6e76
$(PKG)_FILE     := Registry.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/4/47/Registry.zip
$(PKG)_DEPS     := cc nsis

define $(PKG)_BUILD
    $(INSTALL) '$(SOURCE_DIR)/Desktop/Plugin/registry.dll' '$(PREFIX)/$(TARGET)/share/nsis/Plugins'
endef

$(PKG)_BUILD_STATIC =
