# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := jasper
$(PKG)_WEBSITE  := https://ece.engr.uvic.ca/~frodo/jasper/
$(PKG)_DESCR    := JasPer Image Coding Toolkit
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.0
$(PKG)_CHECKSUM := 9fafac7db080232584d5f4ebe1279ffc9b789679c29079fd24245c9b2420705e
$(PKG)_GH_CONF  := jasper-software/jasper/releases, version-
$(PKG)_DEPS     := cc jpeg

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DJAS_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DJAS_ENABLE_LIBJPEG=ON \
        -DJAS_ENABLE_OPENGL=OFF \
        -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF \
        -DJAS_ENABLE_DOC=OFF \
        -DJAS_ENABLE_PROGRAMS=OFF \
        -DJAS_ENABLE_LIBHEIF=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
