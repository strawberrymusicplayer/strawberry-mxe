# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := openssl
$(PKG)_WEBSITE  := https://www.openssl.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0c789f5
$(PKG)_CHECKSUM := cf553bd28f8afa20606a7923ef159c42c36a4df04cddf54e641b902dfd7c8f13
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
