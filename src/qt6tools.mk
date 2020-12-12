# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6tools
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Tools
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.0.0
$(PKG)_CHECKSUM := b6dc559db447bf394d09dfb238d5c09108f834139a183888179e855c6566bfae
$(PKG)_FILE     := qttools-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qttools-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.0/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc qt6base $(BUILD)~$(PKG)
$(PKG)_DEPS_$(BUILD) := qt6base
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.0/ | \
    $(SED) -n 's,.*href="\(6\.0\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)' -DCMAKE_BUILD_TYPE=Release \
                                               -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/qt6

    cd '$(BUILD_DIR)' && cmake --build .
    cd '$(BUILD_DIR)' && cmake --install .
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && \
        PKG_CONFIG="${TARGET}-pkg-config" \
        PKG_CONFIG_SYSROOT_DIR="/" \
        PKG_CONFIG_LIBDIR="$(PREFIX)/$(TARGET)/lib/pkgconfig" \
        MAKE=$(MAKE) \
        $(TARGET)-cmake '$(SOURCE_DIR)' -DCMAKE_BUILD_TYPE=Release \
                                        -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/qt6 \
                                        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
                                        -DPKG_CONFIG_EXECUTABLE=$(PREFIX)/bin/$(TARGET)-pkg-config \
                                        -DQT_HOST_PATH=$(PREFIX)/x86_64-pc-linux-gnu/qt6 \
                                        -DQT_WILL_BUILD_TOOLS=ON \
                                        -DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON

    mkdir -p '$(BUILD_DIR)/src/designer/src/uitools/CMakeFiles/UiTools_rc.dir' \
             '$(BUILD_DIR)/src/linguist/linguist/CMakeFiles/linguist_rc.dir' \
             '$(BUILD_DIR)/src/assistant/help/CMakeFiles/Help_rc.dir' \
             '$(BUILD_DIR)/src/assistant/assistant/CMakeFiles/assistant_rc.dir'

    touch '$(BUILD_DIR)/src/designer/src/uitools/CMakeFiles/UiTools_rc.dir/UiTools_resource.rc.res' \
          '$(BUILD_DIR)/src/linguist/linguist/CMakeFiles/linguist_rc.dir/linguist_resource.rc.res' \
          '$(BUILD_DIR)/src/assistant/help/CMakeFiles/Help_rc.dir/Help_resource.rc.res' \
          '$(BUILD_DIR)/src/assistant/assistant/CMakeFiles/assistant_rc.dir/assistant_resource.rc.res'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake --build .
    cd '$(BUILD_DIR)' && cmake --install .
    ln -sf '$(PREFIX)/$(TARGET)/qt6/bin/qmake' '$(PREFIX)/bin/$(TARGET)'-qmake-qt6

    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/qmake' '$(PREFIX)/$(TARGET)/qt6/bin/'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/qmake' '$(PREFIX)/$(TARGET)/qt6/bin/qmake.exe'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/moc' '$(PREFIX)/$(TARGET)/qt6/bin/moc.exe'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/rcc' '$(PREFIX)/$(TARGET)/qt6/bin/rcc.exe'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/uic' '$(PREFIX)/$(TARGET)/qt6/bin/uic.exe'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/lrelease' '$(PREFIX)/$(TARGET)/qt6/bin/lrelease'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/lrelease' '$(PREFIX)/$(TARGET)/qt6/bin/lrelease.exe'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/lconvert' '$(PREFIX)/$(TARGET)/qt6/bin/lconvert'
    cp '$(PREFIX)/x86_64-pc-linux-gnu/qt6/bin/lconvert' '$(PREFIX)/$(TARGET)/qt6/bin/lconvert.exe'

endef
