# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := xz
$(PKG)_WEBSITE  := https://tukaani.org/xz/
$(PKG)_DESCR    := XZ Utils is free general-purpose data compression software with a high compression ratio
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.2.7
$(PKG)_CHECKSUM := 06327c2ddc81e126a6d9a78b0be5014b976a2c0832f492dcfc4755d7facf6d33
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://tukaani.org/xz/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://tukaani.org/xz/' | \
    $(SED) -n 's,.*xz-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
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
