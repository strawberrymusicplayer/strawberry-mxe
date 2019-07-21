# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := openssl
$(PKG)_WEBSITE  := https://www.openssl.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 38f6f99
$(PKG)_CHECKSUM := 77490f08240f286c05396beadb843df92a275a2ef28e662c11d2b5747074a888
$(PKG)_GH_CONF  := openssl/openssl/branches/master
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    # remove previous install
    rm -rfv '$(PREFIX)/$(TARGET)/include/openssl'
    rm -rfv '$(PREFIX)/$(TARGET)/bin/engines'
    rm -fv '$(PREFIX)/$(TARGET)/'*/{libcrypto*,libssl*}
    rm -fv '$(PREFIX)/$(TARGET)/lib/pkgconfig/'{libcrypto*,libssl*,openssl*}

    cd '$(1)' && CC='$(TARGET)-gcc' RC='$(TARGET)-windres' ./Configure \
        @openssl-target@ \
        zlib \
        $(if $(BUILD_STATIC),no-,)shared \
        no-capieng \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' all install_sw -j 1 \
        CC='$(TARGET)-gcc' \
        RANLIB='$(TARGET)-ranlib' \
        AR='$(TARGET)-ar' \
        RC='$(TARGET)-windres' \
        CROSS_COMPILE='$(TARGET)-' \
        $(if $(BUILD_SHARED), ENGINESDIR='$(PREFIX)/$(TARGET)/bin/engines')
endef

$(PKG)_BUILD_i686-w64-mingw32   = $(subst @openssl-target@,mingw,$($(PKG)_BUILD))
$(PKG)_BUILD_x86_64-w64-mingw32 = $(subst @openssl-target@,mingw64,$($(PKG)_BUILD))
