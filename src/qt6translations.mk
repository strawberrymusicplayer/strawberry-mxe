# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6translations
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Translations
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.0.3
$(PKG)_CHECKSUM := f58fdd4ce05a6f1e0530a28b1dcb2d2269497ee27dfd6a73584a5920b0ad9933
$(PKG)_FILE     := qttranslations-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qttranslations-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.0/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt6base qt6tools

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.0/ | \
    $(SED) -n 's,.*href="\(6\.0\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(BUILD)/qt6/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
