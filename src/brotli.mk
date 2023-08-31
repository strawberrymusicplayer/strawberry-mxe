# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := brotli
$(PKG)_WEBSITE  := https://github.com/google/brotli
$(PKG)_DESCR    := Brotli compression format
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.0
$(PKG)_CHECKSUM := e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff
$(PKG)_GH_CONF  := google/brotli/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/lib/libbrotli{common,dec,enc}.dll.a'),)
    $(if $(BUILD_STATIC),rm -fv $(shell echo '$(PREFIX)/$(TARGET)/bin/libbrotli{common,dec,enc}.dll'),)
endef
