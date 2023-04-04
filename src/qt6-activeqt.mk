# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-activeqt
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Active Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.5.0
$(PKG)_CHECKSUM := 25b0aacbd9aaac3822ee44ac201a159d3e63c77bfbce57599c0368f294f89c3b
$(PKG)_SUBDIR   := qtactiveqt-everywhere-src-$($(PKG)_VERSION)
$(PKG)_FILE     := qtactiveqt-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt6-qtbase
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_UPDATE = $(qt6-qtbase_UPDATE)

define $(PKG)_BUILD
    $(QT6_CMAKE) --log-level="DEBUG" -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DQT_BUILD_BENCHMARKS=OFF \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF \
        -DQT_BUILD_TOOLS_BY_DEFAULT=OFF \
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
