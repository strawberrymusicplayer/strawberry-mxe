# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-installer
$(PKG)_IGNORE   :=
$(PKG)_DEPS     := strawberry nsis-plugin-killproc nsis-plugin-shellexecasuser

define $(PKG)_BUILD_SHARED
  $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/strawberry/bin/nsisplugins'
  $(INSTALL) '$(PREFIX)/$(TARGET)/bin/KillProc.dll' '$(PREFIX)/$(TARGET)/apps/strawberry/bin/nsisplugins'
  $(INSTALL) '$(PREFIX)/$(TARGET)/bin/ShellExecAsUser.dll' '$(PREFIX)/$(TARGET)/apps/strawberry/bin/nsisplugins'
  makensis '$(PREFIX)/$(TARGET)/apps/strawberry/bin/strawberry.nsi'
endef

$(PKG)_BUILD_STATIC =
