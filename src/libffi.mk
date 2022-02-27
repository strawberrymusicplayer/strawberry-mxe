# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libffi
$(PKG)_WEBSITE  := https://sourceware.org/libffi/
$(PKG)_DESCR    := A Portable Foreign Function Interface Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.4.2
$(PKG)_CHECKSUM := 540fb721619a6aba3bdeef7d940d8e9e0e6d2c193595bc243241b77ff9e93620
$(PKG)_GH_CONF  := libffi/libffi/tags, v
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/libffi/libffi/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS) --disable-docs
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' -W -Wall -Werror -std=c99 -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libffi.exe' `'$(TARGET)-pkg-config' libffi --cflags --libs`
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
