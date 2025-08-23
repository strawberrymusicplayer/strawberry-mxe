# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := getopt-win
$(PKG)_WEBSITE  := https://github.com/ludvikjerabek/getopt-win
$(PKG)_DESCR    := Full getopt port for unicode and multibyte windows applications
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5d16202
$(PKG)_CHECKSUM := 1961922194544e71a21005f2132a647e7faac905cf18b1f68d38b7e1c64e2518
$(PKG)_GH_CONF  := ludvikjerabek/getopt-win/branches/main
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
