# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtsparkle-qt5
$(PKG)_WEBSITE  := https://github.com/davidsansome/qtsparkle
$(PKG)_DESCR    := Qt 5 auto-update Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7c4bbc9
$(PKG)_CHECKSUM := 7c476f25d16e17e9e9fd21b8abec2ac663e86f076e8ec8ab15808c6ffd86c489
$(PKG)_GH_CONF  := davidsansome/qtsparkle/branches/master
$(PKG)_FILE     := qtsparkle-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc qt5tools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_WITH_QT5=ON
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'prefix=$(PREFIX)/$(TARGET)'; \
     echo 'exec_prefix=$${prefix}'; \
     echo 'libdir=$${exec_prefix}/lib'; \
     echo 'includedir=$${prefix}/include'; \
     echo ''; \
     echo 'Name: $(PKG)'; \
     echo 'Version: '; \
     echo 'Description: Qt auto-updater lib'; \
     echo 'Libs: -L$${libdir} -lqtsparkle-qt5'; \
     echo 'Cflags: -I$${includedir}') \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/qtsparkle-qt5.pc'
endef
