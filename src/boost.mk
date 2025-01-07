# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := boost
$(PKG)_WEBSITE  := https://www.boost.org/
$(PKG)_DESCR    := Boost C++ Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.87.0
$(PKG)_CHECKSUM := af57be25cb4c4f4b413ed692fe378affb4352ea50fbe294a11ef548f4d527d89
$(PKG)_SUBDIR   := boost_$(subst .,_,$($(PKG)_VERSION))
$(PKG)_FILE     := boost_$(subst .,_,$($(PKG)_VERSION)).tar.bz2
$(PKG)_URL      := https://downloads.sourceforge.net/project/boost/boost/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc bzip2 expat zlib xz

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.boost.org/users/download/' | \
    $(SED) -n 's,.*/release/\([0-9][^"/]*\)/.*,\1,p' | \
    grep -v beta | \
    head -1
endef

define $(PKG)_BUILD
    rm -rf '$(PREFIX)/$(TARGET)/include/boost/'
    rm -f "$(PREFIX)/$(TARGET)/lib/libboost"*
    rm -f "$(PREFIX)/$(TARGET)/bin/libboost"*

    # Create user-config
    echo 'using gcc : mxe : $(TARGET)-g++ : <rc>$(TARGET)-windres <archiver>$(TARGET)-ar <ranlib>$(TARGET)-ranlib ;' > '$(1)/user-config.jam'

    cd '$(1)/tools/build/' && ./bootstrap.sh

    cd '$(1)' && ./tools/build/b2 -a -q -j '$(JOBS)' -d1 \
        --prefix='$(PREFIX)/$(TARGET)' \
        --exec-prefix='$(PREFIX)/$(TARGET)/bin' \
        --libdir='$(PREFIX)/$(TARGET)/lib' \
        --includedir='$(PREFIX)/$(TARGET)/include' \
        --ignore-site-config \
        --user-config=user-config.jam \
        --layout=tagged \
        --disable-icu \
        --with-headers \
        abi=ms \
        address-model=$(BITS) \
        architecture=x86 \
        binary-format=pe \
        link=$(if $(BUILD_STATIC),static,shared) \
        runtime-link=$(if $(BUILD_STATIC),static,shared) \
        target-os=windows \
        threading=multi \
        variant='$(MESON_BUILD_TYPE)' \
        toolset=gcc-mxe \
        install
endef
