# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := jasper
$(PKG)_WEBSITE  := https://ece.engr.uvic.ca/~frodo/jasper/
$(PKG)_DESCR    := JasPer Image Coding Toolkit
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.4
$(PKG)_CHECKSUM := 23a3d58cdeacf3abdf9fa1d81dcefee58da6ab330940790c0f27019703bfd2cd
$(PKG)_GH_CONF  := jasper-software/jasper/releases, version-
$(PKG)_DEPS     := cc jpeg

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DJAS_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DJAS_ENABLE_LIBJPEG=ON \
        -DJAS_ENABLE_OPENGL=OFF \
        -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF \
        -DJAS_ENABLE_DOC=OFF \
        -DJAS_ENABLE_PROGRAMS=OFF \
        -DJAS_ENABLE_LIBHEIF=OFF \
        -DJAS_STDC_VERSION=201710L
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
