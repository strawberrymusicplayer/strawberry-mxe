# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-qttranslations
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Translations
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.8.0
$(PKG)_CHECKSUM := 84bf2b67c243cd0c50a08acd7bfa9df2b1965028511815c1b6b65a0687437cb6
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
