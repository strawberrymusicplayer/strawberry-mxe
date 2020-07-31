# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtsparkle
$(PKG)_WEBSITE  := https://github.com/davidsansome/qtsparkle
$(PKG)_DESCR    := Qt auto-update Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4c852e5
$(PKG)_CHECKSUM := 10a45b65f259db1c4984223c10e5b287f5d9c6e03bbc5dbea6d4fc44497108b2
$(PKG)_GH_CONF  := davidsansome/qtsparkle/branches/master
$(PKG)_DEPS     := cc qttools

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DBUILD_WITH_QT4=OFF
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
     echo 'Requires: Qt5Core Qt5Network Qt5Widgets'; \
     echo 'Libs: -L$${libdir} -lqtsparkle-qt5'; \
     echo 'Cflags: -I$${includedir}') \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/qtsparkle-qt5.pc'
endef
