# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := getopt-win
$(PKG)_WEBSITE  := https://github.com/ludvikjerabek/getopt-win
$(PKG)_DESCR    := Full getopt port for unicode and multibyte windows applications
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := c620fc7
$(PKG)_CHECKSUM := aa4d5914d2e10d313f2333c340d61066f5c6c8ed0f073a6c6a2b8f15eaea1a28
$(PKG)_GH_CONF  := ludvikjerabek/getopt-win/branches/main
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # Create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    ( \
     echo 'prefix=$(PREFIX)'; \
     echo 'exec_prefix=$(PREFIX)'; \
     echo 'libdir=$(PREFIX)/lib'; \
     echo 'includedir=$(PREFIX)/include'; \
     echo ''; \
     echo 'Name: getopt'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $($(PKG)_DESCR)'; \
     echo 'Libs: -L$(PREFIX)/lib -lgetopt'; \
     echo 'Cflags: -I$(PREFIX)/include'; \
     ) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/getopt.pc'

endef
