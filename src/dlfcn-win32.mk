# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := dlfcn-win32
$(PKG)_WEBSITE  := https://github.com/dlfcn-win32/dlfcn-win32
$(PKG)_DESCR    := POSIX dlfcn wrapper for Windows
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := c5a5e6d
$(PKG)_CHECKSUM := 42fd1a3ade8cb19ef3501464415d337d0e4ad561eaf4f5b40dcf2e12c0769332
$(PKG)_GH_CONF  := dlfcn-win32/dlfcn-win32/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # can't use $(MXE_CONFIGURE_OPTS), handwritten ./configure
    #   - rejects unknown options
    #   - no support for out-of-source build
    cd '$(SOURCE_DIR)' && ./configure \
        --prefix='$(PREFIX)/$(TARGET)' \
        --cross-prefix='$(TARGET)-' \
        $(if $(BUILD_STATIC), \
            --enable-static --disable-shared , \
            --disable-static --enable-shared )
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
    #$(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)' test.exe testdll.dll

    # create pkg-config file - mostly for psapi dependency
    mkdir -p '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $(PKG)'; \
     echo 'Libs: -ldl'; \
     echo 'Libs.private: -lpsapi'; \
    ) > '$(PREFIX)/$(TARGET)/lib/pkgconfig/dlfcn.pc'
endef
