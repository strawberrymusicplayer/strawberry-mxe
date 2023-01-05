# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-activeqt
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Active Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.4.2
$(PKG)_CHECKSUM := 123d0e6c4e31263a91a8e3acd72ace3f0c7109f1b15a2e18d594e450c47dc5cf
$(PKG)_SUBDIR   := qtactiveqt-everywhere-src-$($(PKG)_VERSION)
$(PKG)_FILE     := qtactiveqt-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt6-qtbase
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_UPDATE = $(qt6-qtbase_UPDATE)

define $(PKG)_BUILD
    $(QT6_CMAKE) --log-level="DEBUG" -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
