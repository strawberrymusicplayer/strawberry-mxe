# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt5-qtwinextras
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 5 WinExtras
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = 5.15.2
$(PKG)_CHECKSUM := 65b8272005dec00791ab7d81ab266d1e3313a3bbd8e54e546d984cf4c4ab550e
$(PKG)_SUBDIR   := qtwinextras-everywhere-src-$($(PKG)_VERSION)
$(PKG)_FILE     := qtwinextras-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.qt.io/official_releases/qt/5.15/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt5-qtbase

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/5.15/ | \
    $(SED) -n 's,.*href="\(5\.15\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake' -after 'LIBS_PRIVATE += -lgdi32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
