# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := afe8ae9
$(PKG)_CHECKSUM := d3b515e026c1f09946835b0d1d3406782e4225cedbecc29a429d4cd6029e837c
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qtbase zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake' '$(SOURCE_DIR)' \
        'static:CONFIG += staticlib' \
        PREFIX=$(PREFIX)/$(TARGET) \
        -after \
        'SUBDIRS = quazip' \
        'win32:LIBS_PRIVATE += -lz' \
        'CONFIG -= dll' \
        'CONFIG += create_prl no_install_prl create_pc' \
        'QMAKE_PKGCONFIG_DESTDIR = pkgconfig' \
        'static:QMAKE_PKGCONFIG_CFLAGS += -DQUAZIP_STATIC' \
        'DESTDIR = ' \
        'DLLDESTDIR = ' \
        'win32:dlltarget.path = $(PREFIX)/$(TARGET)/bin' \
        'target.path = $(PREFIX)/$(TARGET)/lib'  \
        '!static:win32:target.CONFIG = no_dll' \
        'win32:INSTALLS += dlltarget' \
        'INSTALLS += target headers'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
