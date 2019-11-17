# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-installer
$(PKG)_IGNORE   :=
$(PKG)_DEPS     := strawberry killproc

define $(PKG)_BUILD_SHARED
  $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/strawberry/bin/nsisplugins'
  $(INSTALL) '$(PREFIX)/$(TARGET)/bin/killproc.exe' '$(PREFIX)/$(TARGET)/apps/strawberry/bin'
  makensis '$(PREFIX)/$(TARGET)/apps/strawberry/bin/strawberry.nsi'
endef

$(PKG)_BUILD_STATIC =
