# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-plugin-killproc
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/KillProc_plug-in
$(PKG)_DESCR    := KillProc-Plugin (NSIS)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2011-04-09
$(PKG)_CHECKSUM := 6bfcf9b1e6cc024236bf270dcb210b98e725ac543aa7f5f1a74e05c9690230a6
$(PKG)_DEPS     := cc
$(PKG)_FILE     := NSIS-KillProc-Plugin.$($(PKG)_VERSION).zip
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/muldersoft/KillProc-Plugin (NSIS)/$($(PKG)_FILE)

define $(PKG)_BUILD
    $(INSTALL) '$(SOURCE_DIR)/KillProc.dll' '$(PREFIX)/$(TARGET)/bin'
endef

$(PKG)_BUILD_STATIC =
