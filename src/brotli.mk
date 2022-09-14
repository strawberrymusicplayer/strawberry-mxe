# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := brotli
$(PKG)_WEBSITE  := https://github.com/google/brotli
$(PKG)_DESCR    := Brotli compression format
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.9
$(PKG)_CHECKSUM := f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46
$(PKG)_GH_CONF  := google/brotli/tags, v
$(PKG)_DEPS     := cc

$(PKG)_STATIC_PATCH := $(realpath $(TOP_DIR)/src/brotli-static.patch)

define $(PKG)_BUILD
    $(if $(BUILD_STATIC),cd '$(SOURCE_DIR)' && patch -p1 < '$($(PKG)_STATIC_PATCH)',)
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/lib/libbrotli{common,dec,enc}.dll.a'),)
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/bin/libbrotli{common,dec,enc}.dll'),)
endef
