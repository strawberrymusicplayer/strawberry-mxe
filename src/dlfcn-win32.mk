# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := dlfcn-win32
$(PKG)_WEBSITE  := https://github.com/dlfcn-win32/dlfcn-win32
$(PKG)_DESCR    := POSIX dlfcn wrapper for Windows
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.3.1
$(PKG)_CHECKSUM := f7248a8baeb79d9bcd5f702cc08a777431708758e70d1730b59674c5e795e88a
$(PKG)_GH_CONF  := dlfcn-win32/dlfcn-win32/tags, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config file - mostly for psapi dependency
    mkdir -p '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $(PKG)'; \
     echo 'Libs: -ldl'; \
     echo 'Libs.private: -lpsapi'; \
    ) > '$(PREFIX)/$(TARGET)/lib/pkgconfig/dlfcn.pc'
endef
