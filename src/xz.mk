# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := xz
$(PKG)_WEBSITE  := https://tukaani.org/xz/
$(PKG)_DESCR    := XZ Utils is free general-purpose data compression software with a high compression ratio
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.6.2
$(PKG)_CHECKSUM := a9db3bb3d64e248a0fae963f8fb6ba851a26ba1822e504dc0efd18a80c626caf
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://downloads.sourceforge.net/project/lzmautils/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/lzmautils/files/' | \
    $(SED) -n 's,.*xz-\([0-9.]*\)\.tar.*,\1,p' | \
    sort -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-threads=$(if $(findstring win32,$(MXE_GCC_THREADS)),vista,posix) \
        --disable-rpath \
        --disable-nls \
        --disable-doc
    $(MAKE) -C '$(BUILD_DIR)' src/liblzma -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' src/liblzma -j 1 install
endef
