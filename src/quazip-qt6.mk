# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt6
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 02aa5ae
$(PKG)_CHECKSUM := 0797695a4daadee18420c6ff33eb797202cf07cfe1cad9b614b77f055a37b3dc
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc zlib qt6-qtbase qt6-qttools qt6-qtcore5compat

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
                                         -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
                                         -DCMAKE_PREFIX_PATH=$(PREFIX)/$(TARGET)/qt6/lib/cmake \
                                         -DQUAZIP_QT_MAJOR_VERSION=6

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
