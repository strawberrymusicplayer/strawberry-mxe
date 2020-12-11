# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt5translations
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 5 Translations
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = 5.15.2
$(PKG)_CHECKSUM := d5788e86257b21d5323f1efd94376a213e091d1e5e03b45a95dd052b5f570db8
$(PKG)_SUBDIR   := qttranslations-everywhere-src-$($(PKG)_VERSION)
$(PKG)_FILE     := qttranslations-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.qt.io/official_releases/qt/5.15/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt5base qt5tools

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
endef
