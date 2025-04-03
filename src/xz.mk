# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := xz
$(PKG)_WEBSITE  := https://tukaani.org/xz/
$(PKG)_DESCR    := XZ Utils is free general-purpose data compression software with a high compression ratio
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.8.1
$(PKG)_CHECKSUM := 0b54f79df85912504de0b14aec7971e3f964491af1812d83447005807513cd9e
$(PKG)_GH_CONF  := tukaani-project/xz/releases/latest, v
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://github.com/tukaani-project/$(PKG)/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

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
