# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-qtbase
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Base
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.6.3
$(PKG)_CHECKSUM := 0493fd0b380c4edf8872f011a7f26d245aa4cdd75b349904ef340a22dedf7462
$(PKG)_FILE     := qtbase-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qtbase-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc openssl pcre2 fontconfig freetype harfbuzz glib zlib libpng zstd brotli jpeg sqlite mesa $(BUILD)~$(PKG) $(BUILD)~qt6-qttools
$(PKG)_DEPS_$(BUILD) :=
$(PKG)_OO_DEPS_$(BUILD) += qt6-conf ninja

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.6/ | \
    $(SED) -n 's,.*href="\(6\.[0-9]*\.[^/]*\)/".*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    rm -rf '$(PREFIX)/$(TARGET)/qt6'
    rm -rf $(SOURCE_DIR)/src/3rdparty/{freetype,harfbuzz-ng,libjpeg,libpng,pixman,sqlite,zlib}
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
        -DQT_FORCE_BUILD_TOOLS=ON \
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
        -DFEATURE_style_windows11=ON \
        -DFEATURE_system_zlib=ON \
        -DFEATURE_system_png=ON \
        -DFEATURE_system_jpeg=ON \
        -DFEATURE_system_pcre2=ON \
        -DFEATURE_system_freetype=ON \
        -DFEATURE_system_harfbuzz=ON \
        -DFEATURE_system_sqlite=ON

    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'

    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/moc' '$(PREFIX)/$(TARGET)/qt6/bin/moc.exe'
    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/rcc' '$(PREFIX)/$(TARGET)/qt6/bin/rcc.exe'
    $(INSTALL) -m755 '$(PREFIX)/$(BUILD)/qt6/bin/uic' '$(PREFIX)/$(TARGET)/qt6/bin/uic.exe'

endef

define $(PKG)_BUILD_$(BUILD)
    rm -rf '$(PREFIX)/$(BUILD)/qt6'
    rm -rf $(SOURCE_DIR)/src/3rdparty/{freetype,harfbuzz-ng,libjpeg,libpng,pixman,sqlite}
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -G Ninja \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)/qt6' \
        -DINSTALL_LIBEXECDIR='$(PREFIX)/$(TARGET)/qt6/bin' \
        -DQT_BUILD_{TESTS,EXAMPLES,BENCHMARKS,MANUAL_TESTS,MINIMAL_STATIC_TESTS}=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_USE_GOLD_LINKER_ALIAS=OFF \
        -DFEATURE_{accessibility,androiddeployqt,brotli,dbus,egl,evdev,eventfd,fontconfig,freetype,gif,glib,gui,harfbuzz,ico,icu,jpeg,opengl,opengl_desktop,openssl,pch,pcre2,pdf,png,printer,sql,style_fusion,testlib,vulkan,widgets,xcb,xcb_xlib,xkbcommon,xml,zstd}=OFF \
        -DFEATURE_DEVELOPER_BUILD=ON \
        -DINPUT_opengl=OFF

    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    '$(TARGET)-cmake' --install '$(BUILD_DIR)'
endef
