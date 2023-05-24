# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-qtbase
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Base
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.5.1
$(PKG)_CHECKSUM := db56fa1f4303a1189fe33418d25d1924931c7aef237f89eea9de58e858eebfed
$(PKG)_FILE     := qtbase-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qtbase-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc openssl pcre2 fontconfig freetype harfbuzz glib zlib libpng zstd brotli jpeg sqlite mesa $(BUILD)~$(PKG) $(BUILD)~qt6-qttools
$(PKG)_DEPS_$(BUILD) :=
$(PKG)_OO_DEPS_$(BUILD) += qt6-conf ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.5/ | \
    $(SED) -n 's,.*href="\(6\.[0-9]*\.[^/]*\)/".*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    rm -rf $(SOURCE_DIR)/src/3rdparty/{freetype,harfbuzz-ng,libjpeg,libpng,pixman,sqlite,zlib}
    mv -v '$(PREFIX)/$(TARGET)/cmake/pcre2-config.cmake' '$(PREFIX)/$(TARGET)/cmake/pcre2-config.cmake_'
    mv -v '$(PREFIX)/$(TARGET)/cmake/pcre2-config-version.cmake' '$(PREFIX)/$(TARGET)/cmake/pcre2-config-version.cmake_'
    mkdir -p '$(PREFIX)/$(TARGET)/qt6/bin/'
    PKG_CONFIG="${TARGET}-pkg-config" \
    PKG_CONFIG_SYSROOT_DIR="/" \
    PKG_CONFIG_LIBDIR="$(PREFIX)/$(TARGET)/lib/pkgconfig" \
    '$(TARGET)-cmake' --log-level="DEBUG" -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -G Ninja \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)/qt6' \
        -DPKG_CONFIG_EXECUTABLE='$(PREFIX)/bin/$(TARGET)-pkg-config' \
        -DQT_HOST_PATH='$(PREFIX)/$(BUILD)/qt6' \
        -DQT_QMAKE_TARGET_MKSPEC=win32-g++ \
        -DQT_QMAKE_DEVICE_OPTIONS='CROSS_COMPILE=$(TARGET)-;PKG_CONFIG=$(TARGET)-pkg-config' \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_BENCHMARKS=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF \
        -DQT_BUILD_TOOLS_BY_DEFAULT=ON \
        -DQT_WILL_BUILD_TOOLS=ON \
        -DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_rpath=OFF \
        -DFEATURE_pkg_config=ON \
        -DFEATURE_accessibility=ON \
        -DFEATURE_brotli=ON \
        -DFEATURE_fontconfig=OFF \
        -DFEATURE_freetype=ON \
        -DFEATURE_harfbuzz=ON \
        -DFEATURE_pcre2=ON \
        -DFEATURE_schannel=ON \
        -DFEATURE_openssl=ON \
        -DFEATURE_openssl_linked=$(CMAKE_SHARED_BOOL) \
        -DFEATURE_opengl=ON \
        -DFEATURE_opengl_dynamic=ON \
        -DFEATURE_use_gold_linker_alias=OFF \
        -DFEATURE_glib=ON \
        -DFEATURE_icu=ON \
        -DFEATURE_directfb=OFF \
        -DFEATURE_dbus=OFF \
        -DFEATURE_sql=ON \
        -DFEATURE_sql_sqlite=ON \
        -DFEATURE_sql_odbc=ON \
        -DFEATURE_sql_mysql=OFF \
        -DFEATURE_sql_psql=OFF \
        -DFEATURE_jpeg=ON \
        -DFEATURE_png=ON \
        -DFEATURE_gif=ON \
        -DFEATURE_style_windows=ON \
        -DFEATURE_style_windowsvista=ON \
        -DFEATURE_system_zlib=ON \
        -DFEATURE_system_png=ON \
        -DFEATURE_system_jpeg=ON \
        -DFEATURE_system_pcre2=ON \
        -DFEATURE_system_freetype=ON \
        -DFEATURE_system_harfbuzz=ON \
        -DFEATURE_system_sqlite=ON

    mv -v '$(PREFIX)/$(TARGET)/cmake/pcre2-config.cmake_' '$(PREFIX)/$(TARGET)/cmake/pcre2-config.cmake'
    mv -v '$(PREFIX)/$(TARGET)/cmake/pcre2-config-version.cmake_' '$(PREFIX)/$(TARGET)/cmake/pcre2-config-version.cmake'

    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'

    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/moc' '$(PREFIX)/$(TARGET)/qt6/bin/moc.exe'
    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/rcc' '$(PREFIX)/$(TARGET)/qt6/bin/rcc.exe'
    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/uic' '$(PREFIX)/$(TARGET)/qt6/bin/uic.exe'

endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && CXXFLAGS='$(CXXFLAGS) -Wno-unused-but-set-variable' '$(SOURCE_DIR)/configure' \
        -prefix '$(PREFIX)/$(TARGET)/qt6' \
        -libexecdir '$(PREFIX)/$(TARGET)/qt6/bin' \
        -static \
        -release \
        -opensource \
        -confirm-license \
        -developer-build \
        -make tools \
        -nomake examples \
        -nomake tests \
        -nomake benchmarks \
        -nomake manual-tests \
        -nomake minimal-static-tests \
        -no-{accessibility,glib,openssl,opengl,dbus,fontconfig,icu,harfbuzz,xcb-xlib,xcb,xkbcommon,eventfd,evdev,gif,ico,libjpeg,pch,zstd} \
        -no-sql-{db2,ibase,mysql,oci,odbc,psql,sqlite} \
        -no-use-gold-linker

    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    '$(TARGET)-cmake' --install '$(BUILD_DIR)'
endef
