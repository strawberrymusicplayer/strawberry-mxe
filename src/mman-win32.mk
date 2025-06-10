# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mman-win32
$(PKG)_WEBSITE  := https://code.google.com/p/mman-win32/
$(PKG)_DESCR    := A light implementation of the mmap functions for MinGW
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := fedbdbf
$(PKG)_CHECKSUM := 7eb84c9df66201ffa21cd4d372ad9d529fdeac285b8b2eb70ae1be196e57ab06
$(PKG)_GH_CONF  := alitrack/mman-win32/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DBUILD_TESTS=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
    '$(TARGET)-gcc' -W -Wall '$(1)/test.c' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' -lmman
endef
