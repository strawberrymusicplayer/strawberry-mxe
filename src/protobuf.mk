# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_WEBSITE  := https://github.com/google/protobuf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.15.8
$(PKG)_CHECKSUM := 0cbdc9adda01f6d2facc65a22a2be5cecefbefe5a09e5382ee8879b522c04441
$(PKG)_GH_CONF  := google/protobuf/tags, v
$(PKG)_DEPS     := cc googletest zlib $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest libtool

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))
    cd '$(SOURCE_DIR)' && ./autogen.sh

    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
        $(if $(BUILD_CROSS), \
            --with-zlib \
            --with-protoc='$(PREFIX)/$(BUILD)/bin/protoc' \
        )
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_CROSS),
        '$(TARGET)-g++' \
            -W -Wall -Werror -ansi -pedantic -std=c++14 \
            '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-protobuf.exe' \
            `'$(TARGET)-pkg-config' protobuf --cflags --libs`
    )
endef
