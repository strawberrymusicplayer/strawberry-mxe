# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis-plugin-shellexecasuser
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/ShellExecAsUser_plug-in
$(PKG)_DESCR    := ShellExecAsUser (NSIS)
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 79bdd3e54a9ba9c30af85557b475d2322286f8726687f2e23afa772aac6049ab
$(PKG)_DEPS     := cc
$(PKG)_FILE     := ShellExecAsUserUnicodeUpdate.zip
$(PKG)_URL      := https://nsis.sourceforge.io/mediawiki/images/1/1d/ShellExecAsUserUnicodeUpdate.zip

define $(PKG)_BUILD
    $(INSTALL) '$(SOURCE_DIR)/unicode/ShellExecAsUser.dll' '$(PREFIX)/$(TARGET)/bin'
endef

$(PKG)_BUILD_STATIC =
