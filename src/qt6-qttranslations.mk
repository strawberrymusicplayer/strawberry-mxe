# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-qttranslations
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Translations
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.7.3
$(PKG)_CHECKSUM := dcc762acac043b9bb5e4d369b6d6f53e0ecfcf76a408fe0db5f7ef071c9d6dc8
$(PKG)_FILE     := qttranslations-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qttranslations-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt6-qtbase qt6-qttools

$(PKG)_UPDATE = $(qt6-qtbase_UPDATE)

define $(PKG)_BUILD
    $(QT6_CMAKE) --log-level="DEBUG" -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
