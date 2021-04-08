# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mesa
$(PKG)_WEBSITE  := https://mesa3d.org
$(PKG)_DESCR    := The Mesa 3D Graphics Library
$(PKG)_VERSION  := 21.0.2
$(PKG)_CHECKSUM := 46c1dc5bb54a372dee43ec3c067229c299187d5bdadf1402756bbf66a6df5b88
$(PKG)_SUBDIR   := mesa-$($(PKG)_VERSION)
$(PKG)_FILE     := mesa-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := ftp://ftp.freedesktop.org/pub/mesa/$($(PKG)_FILE)
$(PKG)_DEPS     := cc scons-local

define $(PKG)_UPDATE
    $(call GET_LATEST_VERSION, https://archive.mesa3d.org, mesa-)
endef

define $(PKG)_BUILD
    $(SCONS_PREP)
    cd '$(SOURCE_DIR)' && \
    MINGW_PREFIX='$(TARGET)-' $(SCONS_LOCAL) \
        platform=windows \
        toolchain=crossmingw \
        machine=$(if $(findstring x86_64,$(TARGET)),x86_64,x86) \
        verbose=1 \
        build=release \
        libgl-gdi

    for i in EGL GLES GLES2 GLES3 KHR; do \
        $(INSTALL) -d "$(PREFIX)/$(TARGET)/include/$$i"; \
        $(INSTALL) -m 644 "$(1)/include/$$i/"* "$(PREFIX)/$(TARGET)/include/$$i/"; \
    done
    $(INSTALL) -m 755 '$(1)/build/windows-$(if $(findstring x86_64,$(TARGET)),x86_64,x86)/gallium/targets/libgl-gdi/opengl32.dll' '$(PREFIX)/$(TARGET)/bin/'
endef
