# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := abseil-cpp
$(PKG)_DESC     := Abseil Common Libraries (C++)
$(PKG)_WEBSITE  := https://github.com/abseil/abseil-cpp
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 20230125.2
$(PKG)_CHECKSUM := 9a2b5752d7bfade0bdeee2701de17c9480620f8b237e1964c1b9967c75374906
$(PKG)_GH_CONF  := abseil/abseil-cpp/releases/latest
$(PKG)_DEPS     := cc
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL)
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
