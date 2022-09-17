# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-inetc
$(PKG)_WEBSITE  := 
$(PKG)_DESCR    := NSIS INetC Plugin
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0
$(PKG)_CHECKSUM := 88d9dcffbe967df6ee9f5820f8199a673383e581bf650dbc35b94846314b1a4b
$(PKG)_FILE     := Inetc.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/c/c9/Inetc.zip
$(PKG)_DEPS     := cc nsis

define $(PKG)_BUILD
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/share/nsis/Plugins/x86-unicode'
    $(INSTALL) '$(SOURCE_DIR)/Plugins/x86-unicode/INetC.dll' '$(PREFIX)/$(TARGET)/share/nsis/Plugins/x86-unicode'
endef

$(PKG)_BUILD_STATIC =
