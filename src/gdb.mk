# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gdb
$(PKG)_WEBSITE  := https://www.gnu.org/software/gdb/
$(PKG)_DESCR    := GDB: The GNU Project Debugger
$(PKG)_VERSION  := 13.2
$(PKG)_CHECKSUM := fd5bebb7be1833abdb6e023c2f498a354498281df9d05523d8915babeb893f0a
$(PKG)_SUBDIR   := gdb-$($(PKG)_VERSION)
$(PKG)_FILE     := gdb-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://ftp.gnu.org/gnu/$(PKG)/$($(PKG)_FILE)
$(PKG)_URL_2    := https://ftpmirror.gnu.org/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gmp dlfcn-win32 expat libiconv mman-win32 readline zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ftp.gnu.org/gnu/gdb/?C=M;O=D' | \
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
        host_configargs="LIBS=\"-lmman\"" \
        LDFLAGS='-Wl,--allow-multiple-definition'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(INSTALL) -m755 '$(BUILD_DIR)/gdb/gdb.exe' '$(PREFIX)/$(TARGET)/bin/'

endef

# Static build fails in the CI while it works locally.
# libintl linking problems. Disabling static build until issue is resolved.

$(PKG)_BUILD_STATIC =
