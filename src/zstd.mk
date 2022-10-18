# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := zstd
$(PKG)_WEBSITE  := https://github.com/facebook/zstd
$(PKG)_DESCR    := Zstandard is a fast lossless compression algorithm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.2
$(PKG)_CHECKSUM := f7de13462f7a82c29ab865820149e778cbfe01087b3a55b5332707abf9db4a6e
$(PKG)_GH_CONF  := facebook/zstd/releases/latest,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DZSTD_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        -DZSTD_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DZSTD_BUILD_PROGRAMS=OFF \
        '$(SOURCE_DIR)/build/cmake'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' `'$(TARGET)-pkg-config' lib$(PKG) --cflags --libs`

endef
