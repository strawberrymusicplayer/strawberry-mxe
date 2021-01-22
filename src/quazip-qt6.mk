# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt6
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7d7661d
$(PKG)_CHECKSUM := 58c709f1e778a5c6a4c76d1e7937ede058549c49e9ce935b45009643a66d6736
$(PKG)_GH_CONF  := stachenov/quazip/branches/master
$(PKG)_DEPS     := cc zlib qt6base qt6tools qt6qt5compat

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
                                         -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
                                         -DCMAKE_PREFIX_PATH=$(PREFIX)/$(TARGET)/qt6/lib/cmake \
                                         -DQUAZIP_QT_MAJOR_VERSION=6

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
