# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gnutls
$(PKG)_WEBSITE  := https://www.gnu.org/software/gnutls/
$(PKG)_DESCR    := The GnuTLS Transport Layer Security Library
$(PKG)_VERSION  := 3.7.7
$(PKG)_CHECKSUM := be9143d0d58eab64dba9b77114aaafac529b6c0d7e81de6bdf1c9b59027d2106
$(PKG)_SUBDIR   := gnutls-$($(PKG)_VERSION)
$(PKG)_FILE     := gnutls-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gnupg.org/ftp/gcrypt/gnutls/v3.7/$($(PKG)_FILE)
$(PKG)_URL_2    := https://www.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/gnutls/v3.5/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gettext gmp libidn2 libtasn1 libunistring nettle zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- https://gnupg.org/ftp/gcrypt/gnutls/v3.7/ | \
    $(SED) -n 's,.*gnutls-\([1-9]\+\(\.[0-9]\+\)\+\)\..*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-rpath \
        --disable-nls \
        --disable-guile \
        --disable-doc \
        --disable-tests \
        --without-p11-kit \
        --disable-silent-rules
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install

    '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-gnutls.exe' `'$(TARGET)-pkg-config' gnutls --cflags --libs`
endef
