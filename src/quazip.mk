# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := quazip
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ab9b50f
$(PKG)_CHECKSUM := 22bf72fdef4c3e21b4ff27882f520b02977ce5ddb4a8e3e71b6e50d07896a2d5
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
