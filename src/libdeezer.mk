# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libdeezer
$(PKG)_WEBSITE  := https://www.deezer.com/
$(PKG)_DESCR    := Deezer Native SDK
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.10
$(PKG)_CHECKSUM := 6198ae56778f9ef39c1d7e2e6d23d779a245c19742e58cf85dd2ad0662e45cae
$(PKG)_DEPS     := cc curl
$(PKG)_FILE     := deezer-native-sdk-v$($(PKG)_VERSION).zip
$(PKG)_URL      := https://build-repo.deezer.com/native_sdk/$($(PKG)_FILE)

define $(PKG)_BUILD

    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Bins/Platforms/Windows/DLLs/libdeezer.x86.dll' '$(PREFIX)/$(TARGET)/bin'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Bins/Platforms/Windows/DLLs/libdeezer.x86.dll' '$(PREFIX)/$(TARGET)/lib'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Bins/Platforms/Windows/DLLs/libdeezer.x64.dll' '$(PREFIX)/$(TARGET)/bin'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Bins/Platforms/Windows/DLLs/libdeezer.x64.dll' '$(PREFIX)/$(TARGET)/lib'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-api.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-connect.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-object.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-offline-sync.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-offline.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-player.h' '$(PREFIX)/$(TARGET)/include/deezer'
    $(INSTALL) '$(SOURCE_DIR)/deezer-native-sdk-v$($(PKG)_VERSION)/SDK/Include/deezer-track.h' '$(PREFIX)/$(TARGET)/include/deezer'

    # Create pkg-config file
    mkdir -p '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    ( \
     echo 'prefix=$(PREFIX)/$(TARGET)'; \
     echo 'exec_prefix=$${prefix}'; \
     echo 'libdir=$${exec_prefix}/bin'; \
     echo 'includedir=$${prefix}/include'; \
     echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $($(PKG)_DESC)'; \
     echo 'Libs: -L$${libdir} -ldeezer'; \
     echo 'Libs.private: -lm'; \
    ) > '$(PREFIX)/$(TARGET)/lib/pkgconfig/libdeezer.pc'

endef

$(PKG)_BUILD_STATIC =
