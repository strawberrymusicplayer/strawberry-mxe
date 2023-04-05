# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := zstd
$(PKG)_WEBSITE  := https://github.com/facebook/zstd
$(PKG)_DESCR    := Zstandard is a fast lossless compression algorithm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.5
$(PKG)_CHECKSUM := 9c4396cc829cfae319a6e2615202e82aad41372073482fce286fac78646d3ee4
$(PKG)_GH_CONF  := facebook/zstd/releases/latest,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)/build/cmake' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DZSTD_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        -DZSTD_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DZSTD_BUILD_PROGRAMS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' `'$(TARGET)-pkg-config' lib$(PKG) --cflags --libs`

endef
