# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := getopt-win
$(PKG)_WEBSITE  := https://github.com/ludvikjerabek/getopt-win
$(PKG)_DESCR    := Full getopt port for unicode and multibyte windows applications
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3ff5d91
$(PKG)_CHECKSUM := 3eee0292053995276c3a13d2a2817deaf993c226113b236769306d97430de0b5
$(PKG)_GH_CONF  := ludvikjerabek/getopt-win/branches/main
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_SHARED_LIB=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DBUILD_STATIC_LIB=$(CMAKE_STATIC_BOOL) \
        -DBUILD_TESTING=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
