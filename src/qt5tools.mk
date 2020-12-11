# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt5tools
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 5 Tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = 5.15.2
$(PKG)_CHECKSUM := c189d0ce1ff7c739db9a3ace52ac3e24cb8fd6dbf234e49f075249b38f43c1cc
$(PKG)_SUBDIR   := qttools-everywhere-src-$($(PKG)_VERSION)
$(PKG)_FILE     := qttools-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.qt.io/official_releases/qt/5.15/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt5base
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/5.15/ | \
    $(SED) -n 's,.*href="\(5\.15\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install

    # test QUiLoader
    $(CMAKE_TEST)
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
