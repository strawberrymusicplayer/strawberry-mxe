# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := xz
$(PKG)_WEBSITE  := https://tukaani.org/xz/
$(PKG)_DESCR    := XZ Utils is free general-purpose data compression software with a high compression ratio
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.4.6
$(PKG)_CHECKSUM := b92d4e3a438affcf13362a1305cd9d94ed47ddda22e456a42791e630a5644f5c
$(PKG)_GH_CONF  := tukaani-project/xz/releases/latest, v
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
