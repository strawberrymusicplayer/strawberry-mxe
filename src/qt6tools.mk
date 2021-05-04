# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6tools
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.0.4
$(PKG)_CHECKSUM := 935f41131a05440d69e24a14ab5d1216dab8edcfe48140861705755d49648e30
$(PKG)_FILE     := qttools-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qttools-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.0/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc qt6base $(BUILD)~$(PKG)
$(PKG)_DEPS_$(BUILD) := qt6base
$(PKG)_OO_DEPS_$(BUILD) += qt6-conf ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.0/ | \
    $(SED) -n 's,.*href="\(6\.0\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD
    $(QT6_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' -DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'

    cp '$(PREFIX)/$(BUILD)/qt6/bin/qmake' '$(PREFIX)/$(TARGET)/qt6/bin/'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/qmake' '$(PREFIX)/$(TARGET)/qt6/bin/qmake.exe'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/moc' '$(PREFIX)/$(TARGET)/qt6/bin/moc.exe'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/rcc' '$(PREFIX)/$(TARGET)/qt6/bin/rcc.exe'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/uic' '$(PREFIX)/$(TARGET)/qt6/bin/uic.exe'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/lrelease' '$(PREFIX)/$(TARGET)/qt6/bin/lrelease'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/lrelease' '$(PREFIX)/$(TARGET)/qt6/bin/lrelease.exe'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/lconvert' '$(PREFIX)/$(TARGET)/qt6/bin/lconvert'
    cp '$(PREFIX)/$(BUILD)/qt6/bin/lconvert' '$(PREFIX)/$(TARGET)/qt6/bin/lconvert.exe'

endef

define $(PKG)_BUILD_$(BUILD)
    $(QT6_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef

