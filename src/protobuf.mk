# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_DESC     := Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data
$(PKG)_WEBSITE  := https://developers.google.com/protocol-buffers/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 22.2
$(PKG)_CHECKSUM := 1ff680568f8e537bb4be9813bac0c1d87848d5be9d000ebe30f0bc2d7aabe045
$(PKG)_GH_CONF  := protocolbuffers/protobuf/releases/latest, v
$(PKG)_DEPS     := cc googletest zlib abseil-cpp $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest libtool abseil-cpp

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))

    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -Dprotobuf_BUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -Dprotobuf_BUILD_LIBPROTOC=OFF \
        -Dprotobuf_BUILD_PROTOC_BINARIES=ON \
        -Dprotobuf_BUILD_TESTS=OFF \
        -Dprotobuf_BUILD_EXAMPLES=OFF \
        -Dprotobuf_WITH_ZLIB=ON \
        -Dprotobuf_ABSL_PROVIDER='package'

    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
