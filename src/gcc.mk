# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gcc
$(PKG)_WEBSITE  := https://gcc.gnu.org/
$(PKG)_DESCR    := GCC, the GNU Compiler Collection
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 15.2.0
$(PKG)_CHECKSUM := 438fd996826b0c82485a29da03a72d71d6e3541a83ec702df4271f6fe025d24e
$(PKG)_SUBDIR   := gcc-$($(PKG)_VERSION)
$(PKG)_FILE     := gcc-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://ftp.gnu.org/gnu/gcc/gcc-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_URL_2    := https://www.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := binutils mingw-w64 $(addprefix $(BUILD)~,gmp isl mpc mpfr)

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ftp.gnu.org/gnu/gcc/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="gcc-\([0-9][^"]*\)/".*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_CONFIGURE
    # configure gcc
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        --target='$(TARGET)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)' \
        --libdir='$(PREFIX)/lib' \
        --with-sysroot='$(PREFIX)/$(TARGET)' \
        --enable-languages='c,c++,objc' \
        --enable-version-specific-runtime-libs \
        --with-gcc \
        --with-gnu-ld \
        --with-gnu-as \
        --disable-nls \
        $(if $(BUILD_STATIC),--disable-shared) \
        --disable-multilib \
        --without-x \
        --disable-win32-registry \
        --enable-threads=$(MXE_GCC_THREADS) \
        $(MXE_GCC_EXCEPTION_OPTS) \
        --enable-default-ssp \
        --enable-libgomp \
        --with-gmp='$(PREFIX)/$(BUILD)' \
        --with-isl='$(PREFIX)/$(BUILD)' \
        --with-mpc='$(PREFIX)/$(BUILD)' \
        --with-mpfr='$(PREFIX)/$(BUILD)' \
        --with-as='$(PREFIX)/bin/$(TARGET)-as' \
        --with-ld='$(PREFIX)/bin/$(TARGET)-ld' \
        --with-nm='$(PREFIX)/bin/$(TARGET)-nm' \
        --disable-libquadmath \
        $(PKG_CONFIGURE_OPTS)
endef

define $(PKG)_BUILD_mingw-w64
    # install mingw-w64 headers
    $(call PREPARE_PKG_SOURCE,mingw-w64,$(BUILD_DIR))
    mkdir '$(BUILD_DIR).headers'
    cd '$(BUILD_DIR).headers' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-headers/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --enable-sdk=all \
        --enable-idl \
        --with-default-msvcrt=ucrt \
        --with-default-win32-winnt=0x0A00 \
        $(mingw-w64-headers_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).headers' install

    # build standalone gcc
    $($(PKG)_CONFIGURE)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-gcc
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)-gcc

    # build mingw-w64-crt
    mkdir '$(BUILD_DIR).crt'
    cd '$(BUILD_DIR).crt' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-crt/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --with-default-msvcrt=ucrt \
        --with-default-win32-winnt=0x0A00 \
        @gcc-crt-config-opts@ \
        $(mingw-w64-crt_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).crt' -j '$(JOBS)' || $(MAKE) -C '$(BUILD_DIR).crt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).crt' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build posix threads
    mkdir '$(BUILD_DIR).pthreads'
    cd '$(BUILD_DIR).pthreads' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-libraries/winpthreads/configure' $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j '$(JOBS)' || $(MAKE) -C '$(BUILD_DIR).pthreads' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build rest of gcc
    # `all-target-libstdc++-v3` sometimes has parallel failure
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-target-libstdc++-v3 || $(MAKE) -C '$(BUILD_DIR)' -j 1 all-target-libstdc++-v3
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    $($(PKG)_POST_BUILD)
endef

define $(PKG)_POST_BUILD
    $(and $(BUILD_SHARED),
      $(MAKE) -C '$(BUILD_DIR)/$(TARGET)/libgcc' -j 1 toolexecdir='$(PREFIX)/$(TARGET)/bin' SHLIB_SLIBDIR_QUAL= install-shared
      cp -v '$(PREFIX)/lib/gcc/$(TARGET)/$($(PKG)_VERSION)/'*.dll.a '$(PREFIX)/$(TARGET)/lib/'
      cp -v '$(PREFIX)/lib/gcc/$(TARGET)/$($(PKG)_VERSION)/'*.dll '$(PREFIX)/$(TARGET)/bin/'
    )

    # cc1libdir isn't passed to subdirs so install correctly and rm
    $(MAKE) -C '$(BUILD_DIR)/libcc1' -j 1 install cc1libdir='$(PREFIX)/lib/gcc/$(TARGET)/$($(PKG)_VERSION)'

    # overwrite default specs to mimic stack protector handling of glibc
    # ./configure above doesn't do this
    '$(TARGET)-gcc' -dumpspecs > '$(PREFIX)/lib/gcc/$(TARGET)/$($(PKG)_VERSION)/specs'
    $(SED) -i 's,-lmingwex,-lmingwex -lssp_nonshared -lssp,' '$(PREFIX)/lib/gcc/$(TARGET)/$($(PKG)_VERSION)/specs'

    # compile test
    cd '$(PREFIX)/$(TARGET)/bin' && '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic -D_FORTIFY_SOURCE=2 --coverage -fprofile-dir=. -v '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe'
endef

$(PKG)_BUILD_x86_64-w64-mingw32 = $(subst @gcc-crt-config-opts@,--disable-lib32,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_i686-w64-mingw32   = $(subst @gcc-crt-config-opts@,--disable-lib64,$($(PKG)_BUILD_mingw-w64))
