# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt5
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 01b984e
$(PKG)_CHECKSUM := ae50d58bba2522bd9a17af57382f81567521a581d412b09dfc168b45550bf082
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc qt5-qtbase zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
