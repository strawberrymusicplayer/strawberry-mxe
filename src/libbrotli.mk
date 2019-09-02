# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libbrotli
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := a90f3a4
$(PKG)_CHECKSUM := 677bd6d83428c2d0784ee6d56fc5c037ab645714216a7081c6bf1e67d97b3088
$(PKG)_SUBDIR   := libbrotli-$($(PKG)_VERSION)
$(PKG)_FILE     := libbrotli-$($(PKG)_VERSION).tar.bz2
$(PKG)_DEPS     := cc
$(PKG)_URL      := https://files.jkvinge.net/packages/libbrotli/$($(PKG)_FILE)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./autogen.sh
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --target='$(TARGET)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install LDFLAGS='-no-undefined'
endef
