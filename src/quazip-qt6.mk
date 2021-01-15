# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-qt6
$(PKG)_WEBSITE  := https://github.com/stachenov/quazip
$(PKG)_DESCR    := QuaZip Qt 6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0eba143
$(PKG)_CHECKSUM := 39529a4aff3f4d877334b5709a32ecefc5ad8f56a7ac552bd81982167b0e8307
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
