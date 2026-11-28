# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := zstd
$(PKG)_WEBSITE  := https://github.com/facebook/zstd
$(PKG)_DESCR    := Zstandard is a fast lossless compression algorithm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.0
$(PKG)_CHECKSUM := 2ba599ae2a257976278e7e71e998433a387bfd18aa7b78678229fd5d84f5e9b8
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
