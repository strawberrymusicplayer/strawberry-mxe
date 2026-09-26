# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gdb
$(PKG)_WEBSITE  := https://www.gnu.org/software/gdb/
$(PKG)_DESCR    := GDB: The GNU Project Debugger
$(PKG)_VERSION  := 18.1
$(PKG)_CHECKSUM := cd9fc3fe2b47743840e42c1592d3d87f8302eb18639c0b8b4ba0898002e2348f
$(PKG)_SUBDIR   := gdb-$($(PKG)_VERSION)
$(PKG)_FILE     := gdb-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gnuftp.uib.no/$(PKG)/$($(PKG)_FILE)
$(PKG)_URL_2    := https://ftpmirror.gnu.org/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gmp mpfr dlfcn-win32 expat libiconv mman-win32 readline zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gnuftp.uib.no/gdb/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="gdb-\([0-9][^"]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        --host='$(TARGET)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --enable-static \
        --disable-shared \
        --disable-nls \
        host_configargs="LIBS=\"-lmman\"" \
        CFLAGS='-D_WIN32_WINNT=0x0601 -Wno-implicit-function-declaration' \
        CXXFLAGS='-D_WIN32_WINNT=0x0601' \
        LDFLAGS='-Wl,--allow-multiple-definition'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(INSTALL) -m755 '$(BUILD_DIR)/gdb/gdb.exe' '$(PREFIX)/$(TARGET)/bin/'

endef
