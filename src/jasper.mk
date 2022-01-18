# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := jasper
$(PKG)_WEBSITE  := https://www.ece.uvic.ca/~mdadams/jasper/
$(PKG)_DESCR    := JasPer
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.0-unstable3
$(PKG)_CHECKSUM := 9ed8cf7c81df885e25e339a402aea953041a7996cdadf2e806bb951584c12fd4
$(PKG)_GH_CONF  := mdadams/jasper/tags, version-
$(PKG)_DEPS     := cc jpeg

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DJAS_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DJAS_ENABLE_LIBJPEG=ON \
        -DJAS_ENABLE_OPENGL=OFF \
        -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF \
        -DJAS_ENABLE_DOC=OFF \
        -DJAS_ENABLE_PROGRAMS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
