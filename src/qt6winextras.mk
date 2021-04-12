# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6winextras
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 WinExtras
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.0.0
$(PKG)_CHECKSUM := 3984f08d070b4e9a5270d5b5a502bf19e15841913a8e0bacaa52a9afa4e6c9fe
$(PKG)_FILE     := qtwinextras-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qtwinextras-everywhere-src-$($(PKG)_VERSION)
#$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.0/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_URL      := http://files.jkvinge.net/packages/strawberry-dependencies/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc qt6base
$(PKG)_DEPS_$(BUILD) :=
$(PKG)_OO_DEPS_$(BUILD) += qt6-conf ninja

#define $(PKG)_UPDATE
#    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.0/ | \
#    $(SED) -n 's,.*href="\(6\.0\.[^/]*\)/".*,\1,p' | \
#    grep -iv -- '-rc' | \
#    sort |
#    tail -1
#endef

define $(PKG)_BUILD
    $(QT6_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
