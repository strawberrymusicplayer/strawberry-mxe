# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mman-win32
$(PKG)_WEBSITE  := https://code.google.com/p/mman-win32/
$(PKG)_DESCR    := MMA-Win32
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2d1c576
$(PKG)_CHECKSUM := 3b112c8084a29102759e53971ebf1d4d9df48f01c452d0742e1b1569f660f14e
$(PKG)_GH_CONF  := witwall/mman-win32/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' -W -Wall \
        '$(1)/test.c' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        -lmman
endef
