# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ccache
$(PKG)_WEBSITE  := https://github.com/ccache/ccache
$(PKG)_DESCR    := ccache – a fast compiler cache
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.5.1
$(PKG)_CHECKSUM := 51186ebe0326365f4e6131e1caa8911de7da4aa6718efc00680322d63a759517
$(PKG)_GH_CONF  := ccache/ccache/releases/latest, v
$(PKG)_SUBDIR   := ccache-$($(PKG)_VERSION)
$(PKG)_FILE     := ccache-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://github.com/ccache/ccache/releases/download/v$($(PKG)_VERSION)/ccache-$($(PKG)_VERSION).tar.xz
$(PKG)_DEPS     := $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) :=

BOOTSTRAP_PKGS += ccache

$(PKG)_SYS_CONF := $(MXE_CCACHE_DIR)/etc/$(PKG).conf
$(PKG)_USR_CONF := $(MXE_CCACHE_DIR)/$(PKG).conf

ifeq (mxe,$(MXE_USE_CCACHE))
define $(PKG)_BUILD_$(BUILD)
    # remove any previous symlinks
    rm -fv '$(PREFIX)/$(BUILD)/bin/$(BUILD_CC)' '$(PREFIX)/$(BUILD)/bin/$(BUILD_CXX)'

    cmake -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' -DZSTD_FROM_INTERNET=OFF -DREDIS_STORAGE_BACKEND=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_DOCS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_DOCS)

    # setup symlinks
    ln -sf '$(MXE_CCACHE_DIR)/bin/ccache' '$(PREFIX)/$(BUILD)/bin/$(BUILD_CC)'
    ln -sf '$(MXE_CCACHE_DIR)/bin/ccache' '$(PREFIX)/$(BUILD)/bin/$(BUILD_CXX)'

    # https://ccache.samba.org/manual/latest.html#_configuration_settings
    # always set/replace mxe `system` config
    mkdir -p '$(dir $($(PKG)_SYS_CONF))'
    (echo '# ccache system config'; \
     echo '# this file is controlled by mxe, user config is in:'; \
     echo '# $($(PKG)_USR_CONF)'; \
     echo; \
     echo 'base_dir = $(MXE_CCACHE_BASE_DIR)'; \
     echo 'cache_dir = $(MXE_CCACHE_DIR)'; \
     echo 'compiler_check = %compiler% -v'; \
     ) > '$($(PKG)_SYS_CONF)'

    # leave user config alone if set
    [ -f '$($(PKG)_USR_CONF)' ] || \
    (mkdir -p '$(dir $($(PKG)_USR_CONF))' && \
    (echo '# ccache user config'; \
     echo '# https://ccache.samba.org/manual/latest.html#_configuration_settings'; \
     echo '# system config: $($(PKG)_SYS_CONF)'; \
     echo; \
     echo 'max_size = 20.0G'; \
     ) > '$($(PKG)_USR_CONF)')
endef

define $(PKG)_BUILD
    # setup symlinks
    ln -sf '$(MXE_CCACHE_DIR)/bin/ccache' '$(PREFIX)/$(BUILD)/bin/$(TARGET)-gcc'
    ln -sf '$(MXE_CCACHE_DIR)/bin/ccache' '$(PREFIX)/$(BUILD)/bin/$(TARGET)-g++'

    # setup cmake toolchain to allow runtime override
    # CMAKE_CXX_COMPILER_LAUNCHER shows original cc and isn't clear in logs etc.
    mkdir -p '$(CMAKE_TOOLCHAIN_DIR)'
    (echo 'option(MXE_USE_CCACHE "Enable ccache by default" ON)'; \
     echo 'if(MXE_USE_CCACHE)'; \
     echo '  set(CMAKE_C_COMPILER $(PREFIX)/$(BUILD)/bin/$(TARGET)-gcc)'; \
     echo '  set(CMAKE_CXX_COMPILER $(PREFIX)/$(BUILD)/bin/$(TARGET)-g++)'; \
     echo 'endif()'; \
     ) > '$(CMAKE_TOOLCHAIN_DIR)/$(PKG).cmake'
endef
else
define $(PKG)_BUILD_$(BUILD)
    # remove symlinks
    rm -fv '$(PREFIX)/$(BUILD)/bin/$(BUILD_CC)' '$(PREFIX)/$(BUILD)/bin/$(BUILD_CXX)'
endef

define $(PKG)_BUILD
    # remove symlinks and cmake toolchain
    rm -fv '$(PREFIX)/$(BUILD)/bin/$(TARGET)-'*
    rm -fv '$(CMAKE_TOOLCHAIN_DIR)/$(PKG).cmake'
endef
endif
