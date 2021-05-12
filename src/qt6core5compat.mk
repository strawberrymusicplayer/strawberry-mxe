# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6core5compat
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Core Qt 5 Compat
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.1.0
$(PKG)_CHECKSUM := c7d7e6ca2702b8b8b8b251bd271771ec319e5d107bb65f4dba024c200c8fd23c
$(PKG)_FILE     := qt5compat-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qt5compat-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.1/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc qt6base
$(PKG)_DEPS_$(BUILD) :=
$(PKG)_OO_DEPS_$(BUILD) += qt6-conf ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.1/ | \
    $(SED) -n 's,.*href="\(6\.1\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD
    $(QT6_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
