# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_DESC     := Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data
$(PKG)_WEBSITE  := https://developers.google.com/protocol-buffers/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 21.12
$(PKG)_CHECKSUM := 22fdaf641b31655d4b2297f9981fa5203b2866f8332d3c6333f6b0107bb320de
$(PKG)_GH_CONF  := protocolbuffers/protobuf/releases/latest, v
$(PKG)_DEPS     := cc googletest zlib abseil-cpp $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest libtool abseil-cpp

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))

    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -Dprotobuf_WITH_ZLIB=ON \
        -Dprotobuf_BUILD_TESTS=OFF \
        -Dprotobuf_BUILD_EXAMPLES=OFF \
        -Dprotobuf_ABSL_PROVIDER='package'

    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_CROSS), '$(TARGET)-g++' -W -Wall -Werror -ansi -pedantic -std=c++17 '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-protobuf.exe' `'$(TARGET)-pkg-config' protobuf --cflags --libs` )
endef
