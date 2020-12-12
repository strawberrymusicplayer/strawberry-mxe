# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6base
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Base
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.0.0
$(PKG)_CHECKSUM := ae227180272d199cbb15318e3353716afada5c57fd5185b812ae26912c958656
$(PKG)_FILE     := qtbase-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qtbase-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/6.0/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_DEPS     := cc ninja dbus openssl pcre2 fontconfig freetype harfbuzz jpeg libpng zlib zstd sqlite mesa $(BUILD)~$(PKG)
$(PKG)_DEPS_$(BUILD) :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.qt.io/official_releases/qt/6.0/ | \
    $(SED) -n 's,.*href="\(6\.0\.[^/]*\)/".*,\1,p' | \
    grep -iv -- '-rc' | \
    sort |
    tail -1
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        -prefix '$(PREFIX)/$(TARGET)/qt6' \
        -static \
        -release \
        -opensource \
        -confirm-license \
        -no-{eventfd,glib,icu,openssl,opengl} \
        -no-sql-{db2,ibase,mysql,oci,odbc,psql,sqlite} \
        -no-use-gold-linker \
        -nomake examples \
        -nomake tests \
        -make tools

    cd '$(BUILD_DIR)' && cmake --build .
    rm -rf '$(PREFIX)/$(TARGET)/qt6'
    cd '$(BUILD_DIR)' && cmake --install .
    ln -sf '$(PREFIX)/$(TARGET)/qt6/bin/qmake' '$(PREFIX)/bin/$(TARGET)'-qmake-qt6
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && \
        OPENSSL_LIBS="`'$(TARGET)-pkg-config' --libs-only-l openssl`" \
        PKG_CONFIG="${TARGET}-pkg-config" \
        PKG_CONFIG_SYSROOT_DIR="/" \
        PKG_CONFIG_LIBDIR="$(PREFIX)/$(TARGET)/lib/pkgconfig" \
        MAKE=$(MAKE) \
        $(TARGET)-cmake '$(SOURCE_DIR)' \
                                         -DCMAKE_BUILD_TYPE=Release \
                                         -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/qt6 \
                                         -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
                                         -DPKG_CONFIG_EXECUTABLE=$(PREFIX)/bin/$(TARGET)-pkg-config \
                                         -DQT_HOST_PATH=$(PREFIX)/x86_64-pc-linux-gnu/qt6 \
                                         -DQT_BUILD_EXAMPLES=OFF \
                                         -DQT_BUILD_BENCHMARKS=OFF \
                                         -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF \
                                         -DQT_BUILD_TOOLS_BY_DEFAULT=ON \
                                         -DQT_WILL_BUILD_TOOLS=ON \
                                         -DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON \
                                         -DFEATURE_rpath=OFF \
                                         -DFEATURE_pkg_config=ON \
                                         -DFEATURE_openssl=ON \
                                         -DFEATURE_openssl_linked=ON \
                                         -DFEATURE_opengl=ON \
                                         -DFEATURE_opengl_dynamic=ON \
                                         -DFEATURE_use_gold_linker_alias=OFF \
                                         -DFEATURE_glib=OFF \
                                         -DFEATURE_icu=OFF \
                                         -DFEATURE_directfb=OFF \
                                         -DFEATURE_dbus=OFF \
                                         -DFEATURE_sql=ON \
                                         -DFEATURE_sql_sqlite=ON \
                                         -DFEATURE_sql_odbc=OFF \
                                         -DFEATURE_pcre2=ON \
                                         -DFEATURE_style_windows=ON \
                                         -DFEATURE_style_windowsvista=ON \
                                         -DINPUT_sqlite=system \
                                         -DINPUT_libpng=system \
                                         -DINPUT_libjpeg=system \
                                         -DINPUT_freetype=system \
                                         -DINPUT_pcre=system \
                                         -DINPUT_openssl=linked

    mkdir -p '$(BUILD_DIR)/src/concurrent/CMakeFiles/Concurrent_rc.dir' \
             '$(BUILD_DIR)/src/concurrent/CMakeFiles/Sql_rc.dir' \
             '$(BUILD_DIR)/src/network/CMakeFiles/Network_rc.dir' \
             '$(BUILD_DIR)/src/xml/CMakeFiles/Xml_rc.dir' \
             '$(BUILD_DIR)/src/gui/CMakeFiles/Gui_rc.dir' \
             '$(BUILD_DIR)/src/widgets/CMakeFiles/Widgets_rc.dir' \
             '$(BUILD_DIR)/src/testlib/CMakeFiles/Test_rc.dir' \
             '$(BUILD_DIR)/src/printsupport/CMakeFiles/PrintSupport_rc.dir' \
             '$(BUILD_DIR)/qmake/CMakeFiles/qmake_native_rc.dir' \
             '$(BUILD_DIR)/src/dbus/CMakeFiles/DBus_rc.dir'

    touch '$(BUILD_DIR)/src/concurrent/CMakeFiles/Concurrent_rc.dir/Concurrent_resource.rc.res' \
          '$(BUILD_DIR)/src/sql/CMakeFiles/Sql_rc.dir/Sql_resource.rc.res' \
          '$(BUILD_DIR)/src/network/CMakeFiles/Network_rc.dir/Network_resource.rc.res' \
          '$(BUILD_DIR)/src/xml/CMakeFiles/Xml_rc.dir/Xml_resource.rc.res' \
          '$(BUILD_DIR)/src/gui/CMakeFiles/Gui_rc.dir/Gui_resource.rc.res' \
          '$(BUILD_DIR)/src/widgets/CMakeFiles/Widgets_rc.dir/Widgets_resource.rc.res' \
          '$(BUILD_DIR)/src/testlib/CMakeFiles/Test_rc.dir/Test_resource.rc.res' \
          '$(BUILD_DIR)/src/printsupport/CMakeFiles/PrintSupport_rc.dir/PrintSupport_resource.rc.res' \
          '$(BUILD_DIR)/qmake/CMakeFiles/qmake_native_rc.dir/qmake_native_resource.rc.res' \
          '$(BUILD_DIR)/src/dbus/CMakeFiles/DBus_rc.dir/DBus_resource.rc.res'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake --build .
    rm -rf '$(PREFIX)/$(TARGET)/qt6'
    cd '$(BUILD_DIR)' && cmake --install .
    ln -sf '$(PREFIX)/$(TARGET)/qt6/bin/qmake' '$(PREFIX)/bin/$(TARGET)'-qmake-qt6

endef
