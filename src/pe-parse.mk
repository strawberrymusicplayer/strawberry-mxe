# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pe-parse
$(PKG)_WEBSITE  := https://github.com/trailofbits/pe-parse
$(PKG)_DESCR    := Principled, lightweight C/C++ PE parser
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.0
$(PKG)_CHECKSUM := 5b367bb521238758f3ece20e764210d11d695683c611b404fd6fadf4929e7960
$(PKG)_GH_CONF  := trailofbits/pe-parse/releases, v
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

# unpack in pe-util for native and cross build
$(PKG)_DEPS_$(BUILD)  :=
$(PKG)_BUILD_$(BUILD) :=

define $(PKG)_BUILD
    # build and install the cross-library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake -DBUILD_COMMAND_LINE_TOOLS=OFF '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # test cmake find_package() example
    mkdir '$(BUILD_DIR).cmake'
    cd '$(BUILD_DIR).cmake' && $(TARGET)-cmake '$(SOURCE_DIR)/examples/peaddrconv'
    $(MAKE) -C '$(BUILD_DIR).cmake' -j '$(JOBS)'
    $(INSTALL) -m755 '$(BUILD_DIR).cmake/peaddrconv.exe' '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe'
endef
