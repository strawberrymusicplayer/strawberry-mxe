# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_WEBSITE  := https://developers.google.com/protocol-buffers/
$(PKG)_WEBSITE  := Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.20.1
$(PKG)_CHECKSUM := 8b28fdd45bab62d15db232ec404248901842e5340299a57765e48abe8a80d930
$(PKG)_GH_CONF  := protocolbuffers/protobuf/tags, v
$(PKG)_DEPS     := cc googletest zlib $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest libtool

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))
    cd '$(SOURCE_DIR)' && ./autogen.sh

    cd '$(BUILD_DIR)' && CXXFLAGS='-std=c++17' '$(SOURCE_DIR)'/configure $(MXE_CONFIGURE_OPTS) $(if $(BUILD_CROSS), --with-zlib --with-protoc='$(PREFIX)/$(BUILD)/bin/protoc' )
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_CROSS), '$(TARGET)-g++' -W -Wall -Werror -ansi -pedantic -std=c++17 '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-protobuf.exe' `'$(TARGET)-pkg-config' protobuf --cflags --libs` )
endef
