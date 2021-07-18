# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-debug-installer
$(PKG)_IGNORE   :=
$(PKG)_DEPS     := strawberry-debug

define $(PKG)_BUILD_SHARED
  $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/strawberry-debug/bin/nsisplugins'
  makensis '$(PREFIX)/$(TARGET)/apps/strawberry-debug/bin/strawberry.nsi'
endef

$(PKG)_BUILD_STATIC =
