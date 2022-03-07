# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcuefile
$(PKG)_WEBSITE  := https://www.musepack.net/
$(PKG)_DESCR    := Living Audio Compression
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 475
$(PKG)_CHECKSUM := b681ca6772b3f64010d24de57361faecf426ee6182f5969fcf29b3f649133fe7
$(PKG)_SUBDIR   := $(PKG)_r$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)_r$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://files.musepack.net/source/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_SHARED),-DSHARED=ON)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/cuetools'
    $(INSTALL) -m644 '$(SOURCE_DIR)/include/cuetools/cd.h' '$(PREFIX)/$(TARGET)/include/cuetools'
    $(INSTALL) -m644 '$(SOURCE_DIR)/include/cuetools/cdtext.h' '$(PREFIX)/$(TARGET)/include/cuetools'
    $(INSTALL) -m644 '$(SOURCE_DIR)/include/cuetools/cuefile.h' '$(PREFIX)/$(TARGET)/include/cuetools'
endef
