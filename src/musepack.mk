# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := musepack
$(PKG)_WEBSITE  := https://www.musepack.net/
$(PKG)_DESCR    := Living Audio Compression
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 475
$(PKG)_CHECKSUM := a4b1742f997f83e1056142d556a8c20845ba764b70365ff9ccf2e3f81c427b2b
$(PKG)_SUBDIR   := $(PKG)_src_r$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)_src_r$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://files.musepack.net/source/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libcuefile libreplaygain

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.musepack.net/index.php?pg=src' | \
    $(SED) -n 's,.*musepack_src_r\([^>]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    LDFLAGS='$(LDFLAGS) -Wl,--allow-multiple-definition' \
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_SHARED),-DSHARED=ON) \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    $(if $(BUILD_SHARED),
      $(INSTALL) -m644 '$(BUILD_DIR)/libmpcdec/libmpcdec.dll.a' '$(PREFIX)/$(TARGET)/lib/'
      $(INSTALL) -m644 '$(BUILD_DIR)/libmpcdec/libmpcdec.dll' '$(PREFIX)/$(TARGET)/bin/'
    )
endef
