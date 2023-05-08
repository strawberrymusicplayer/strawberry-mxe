# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf
$(PKG)_DESC     := Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data
$(PKG)_WEBSITE  := https://developers.google.com/protocol-buffers/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 23.0
$(PKG)_CHECKSUM := b29fc5fc13926f347b7a8b676ae1e63f7ccdb92c2fc8ca326bc3a883dcc168ac
$(PKG)_GH_CONF  := protocolbuffers/protobuf/releases/latest, v
$(PKG)_DEPS     := cc googletest zlib abseil-cpp $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest libtool abseil-cpp

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))

    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
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
