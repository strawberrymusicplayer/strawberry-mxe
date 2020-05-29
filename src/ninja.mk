# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ninja
$(PKG)_WEBSITE  := https://ninja-build.org/
$(PKG)_DESCR    := A small build system with a focus on speed
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.10.0
$(PKG)_CHECKSUM := 3810318b08489435f8efc19c05525e80a993af5a55baa0dfeae0465a9d45f99f
$(PKG)_GH_CONF  := ninja-build/ninja/releases/latest,v
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.gz
$(PKG)_URL      := https://github.com/ninja-build/ninja/archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_BUILD
    ln -sf '$(PREFIX)/$(BUILD)/bin/ninja' '$(PREFIX)/bin/$(TARGET)-ninja'
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(SOURCE_DIR)' && python2 ./configure.py --bootstrap \
        --with-python="`which python2`" && \
    $(INSTALL) -m755 -D ninja "$(PREFIX)/$(TARGET)/bin/ninja"
endef
