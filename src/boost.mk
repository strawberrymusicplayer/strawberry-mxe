# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := boost
$(PKG)_WEBSITE  := https://www.boost.org/
$(PKG)_DESCR    := Boost C++ Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.71.0
$(PKG)_CHECKSUM := d73a8da01e8bf8c7eda40b4c84915071a8c8a0df4a6734537ddde4a8580524ee
$(PKG)_SUBDIR   := boost_$(subst .,_,$($(PKG)_VERSION))
$(PKG)_FILE     := boost_$(subst .,_,$($(PKG)_VERSION)).tar.bz2
$(PKG)_URL      := https://dl.bintray.com/boostorg/release/$($(PKG)_VERSION)/source/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc bzip2 expat zlib xz

$(PKG)_DEPS_$(BUILD) := zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- -t 2 --timeout=6 'https://www.boost.org/users/download/' | \
    $(SED) -n 's,.*/release/\([0-9][^"/]*\)/.*,\1,p' | \
    grep -v beta | \
    head -1
endef

define GCC_VERSION_MAJOR
$(shell echo $(gcc_VERSION) | cut -f1 -d.)
endef

define GCC_VERSION_MINOR
$(shell echo $(gcc_VERSION) | cut -f2 -d.)
endef

define $(PKG)_CXX_STD
$(shell [ $(1) -gt 6 -o \( $(1) -eq 6 -a $(2) -ge 1 \) ] && echo 14 || echo 11)
endef

define $(PKG)_BUILD
    # old version appears to interfere
    rm -rf '$(PREFIX)/$(TARGET)/include/boost/'
    rm -f "$(PREFIX)/$(TARGET)/lib/libboost"*
    rm -f "$(PREFIX)/$(TARGET)/bin/libboost"*
    # create user-config
    echo 'using gcc : mxe : $(TARGET)-g++ : <rc>$(TARGET)-windres <archiver>$(TARGET)-ar <ranlib>$(TARGET)-ranlib ;' > '$(1)/user-config.jam'

    # compile boost build (b2)
    cd '$(1)/tools/build/' && ./bootstrap.sh

    # cross-build, see b2 options at:
    # https://www.boost.org/build/doc/html/bbv2/overview/invocation.html
    cd '$(1)' && ./tools/build/b2 \
        -a \
        -q \
        -j '$(JOBS)' \
        -d2 \
        --ignore-site-config \
        --user-config=user-config.jam \
        abi=ms \
        address-model=$(BITS) \
        architecture=x86 \
        binary-format=pe \
        link=$(if $(BUILD_STATIC),static,shared) \
        runtime-link=$(if $(BUILD_STATIC),static,shared) \
        target-os=windows \
        threadapi=$(if $(findstring posix,$(MXE_GCC_THREADS)),pthread,win32) \
        threading=multi \
        variant=release \
        toolset=gcc-mxe \
        cxxflags="-std=c++$(call $(PKG)_CXX_STD,$(GCC_VERSION_MAJOR),$(GCC_VERSION_MINOR))" \
        --layout=system \
        --disable-icu \
        --without-mpi \
        --without-python \
        --prefix='$(PREFIX)/$(TARGET)' \
        --exec-prefix='$(PREFIX)/$(TARGET)/bin' \
        --libdir='$(PREFIX)/$(TARGET)/lib' \
        --includedir='$(PREFIX)/$(TARGET)/include' \
        -sEXPAT_INCLUDE='$(PREFIX)/$(TARGET)/include' \
        -sEXPAT_LIBPATH='$(PREFIX)/$(TARGET)/lib' \
        -sPTW32_INCLUDE='$(PREFIX)/$(TARGET)/include' \
        -sPTW32_LIB='$(PREFIX)/$(TARGET)/lib' \
        define="BOOST_THREAD_VERSION=3" \
        define="BOOST_THREAD_DONT_PROVIDE_ONCE_CXX11" \
        define="BOOST_THREAD_PROVIDES_BASIC_THREAD_ID" \
        define="BOOST_THREAD_PROVIDES_GENERIC_SHARED_MUTEX_ON_WIN" \
        install
    ln -sf "$(PREFIX)/$(TARGET)/lib"/libboost_thread_pthread$(if $(BUILD_SHARED),.dll).a \
    "$(PREFIX)/$(TARGET)/lib"/libboost_thread$(if $(BUILD_SHARED),.dll).a
    for lib in `ls "$(PREFIX)/$(TARGET)/lib"/libboost_*$(if $(BUILD_SHARED),.dll).a | tr "\n" " "`; \
    do \
    echo ln -sf "$${lib}" \
    "$(PREFIX)/$(TARGET)/lib/`basename $${lib} $(if $(BUILD_SHARED),.dll).a`-mt$(if $(BUILD_SHARED),.dll).a"; \
    ln -sf "$${lib}" \
    "$(PREFIX)/$(TARGET)/lib/`basename $${lib} $(if $(BUILD_SHARED),.dll).a`-mt$(if $(BUILD_SHARED),.dll).a"; \
    done
    $(if $(BUILD_SHARED), \
        mv -fv '$(PREFIX)/$(TARGET)/lib/'libboost_*.dll '$(PREFIX)/$(TARGET)/bin/')

    # setup cmake toolchain
    printf "set(Boost_THREADAPI "$(if $(findstring posix,$(MXE_GCC_THREADS)),pthread,win32)")\\n\
    set (Boost_USE_STATIC_LIBS $(if $(BUILD_SHARED),OFF,ON))" > '$(CMAKE_TOOLCHAIN_DIR)/$(PKG).cmake'

    '$(TARGET)-g++' \
        -W -Wall -Werror -ansi -U__STRICT_ANSI__ -pedantic \
        '$(PWD)/src/$(PKG)-test.cpp' -o '$(PREFIX)/$(TARGET)/bin/test-boost.exe' \
        -std='c++$(call $(PKG)_CXX_STD,$(GCC_VERSION_MAJOR),$(GCC_VERSION_MINOR))' \
        -lboost_serialization-mt \
        -lboost_thread-mt \
        -lboost_system-mt \
        -lboost_chrono-mt \
        -lboost_context-mt \
        -L'$(PREFIX)/$(TARGET)/lib'

    # test cmake
    mkdir '$(1).test-cmake'
    cd '$(1).test-cmake' && '$(TARGET)-cmake' \
        -DPKG=$(PKG) \
        -DPKG_VERSION=$($(PKG)_VERSION) \
        '$(PWD)/src/cmake/test'
    $(MAKE) -C '$(1).test-cmake' -j 1 install
endef

define $(PKG)_BUILD_$(BUILD)
    # old version appears to interfere
    rm -rf '$(PREFIX)/$(TARGET)/include/boost/'
    rm -f "$(PREFIX)/$(TARGET)/lib/libboost"*

    # compile boost build (b2)
    cd '$(SOURCE_DIR)/tools/build/' && ./bootstrap.sh

    # minimal native build - for more features, replace:
    # --with-system \
    # --with-filesystem \
    #
    # with:
    # --without-mpi \
    # --without-python \

    cd '$(SOURCE_DIR)' && \
        $(if $(call seq,darwin,$(OS_SHORT_NAME)),PATH=/usr/bin:$$PATH) \
        ./tools/build/b2 \
            -a \
            -q \
            -j '$(JOBS)' \
            --ignore-site-config \
            variant=release \
            link=static \
            threading=multi \
            runtime-link=static \
            --disable-icu \
            --with-system \
            --with-filesystem \
            --build-dir='$(BUILD_DIR)' \
            --prefix='$(PREFIX)/$(TARGET)' \
            --exec-prefix='$(PREFIX)/$(TARGET)/bin' \
            --libdir='$(PREFIX)/$(TARGET)/lib' \
            --includedir='$(PREFIX)/$(TARGET)/include' \
            install
endef
