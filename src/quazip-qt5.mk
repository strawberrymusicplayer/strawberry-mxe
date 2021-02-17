# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt5
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := de8125c
$(PKG)_CHECKSUM := 7f3c2ec531b4d056442e63d8ded296a9ea832a56834463e91c58d9a06022cd09
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qt5base zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
