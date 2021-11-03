# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt5
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 02aa5ae
$(PKG)_CHECKSUM := 0797695a4daadee18420c6ff33eb797202cf07cfe1cad9b614b77f055a37b3dc
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qt5-qtbase zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
