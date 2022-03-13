# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := file
$(PKG)_WEBSITE  := https://www.darwinsys.com/file/
$(PKG)_DESCR    := Free File Command and Magic Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.41
$(PKG)_CHECKSUM := 13e532c7b364f7d57e23dfeea3147103150cb90593a57af86c10e4f6e411603f
$(PKG)_SUBDIR   := file-$($(PKG)_VERSION)
$(PKG)_FILE     := file-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://astron.com/pub/file/$($(PKG)_FILE)
$(PKG)_URL_2    := https://distfiles.macports.org/file/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libgnurx bzip2

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://astron.com/pub/file/' | \
    grep 'file-' | \
    $(SED) -n 's,.*file-\([0-9][^>]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD

    # "file" needs a runnable version of the "file" utility
    # itself. This must match the source code regarding its
    # version. Therefore we build a native one ourselves first.

    cp -Rp '$(1)' '$(1).native'
    cd '$(1).native' && ./configure
    cd '$(1).native' && $(MAKE) -j '$(JOBS)'

    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) CFLAGS=-DHAVE_PREAD
    $(MAKE) -C '$(1)' -j '$(JOBS)' FILE_COMPILE='$(1).native/src/file'
    $(MAKE) -C '$(1)' -j 1 install

    '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-file.exe' -lmagic -lgnurx -lshlwapi
endef
