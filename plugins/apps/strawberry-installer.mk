# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-installer
$(PKG)_IGNORE   :=
$(PKG)_DEPS     := strawberry

define $(PKG)_BUILD_SHARED
  makensis '$(PREFIX)/$(TARGET)/apps/strawberry/bin/strawberry.nsi'
endef

$(PKG)_BUILD_STATIC =
