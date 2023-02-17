# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := abseil-cpp
$(PKG)_DESC     := Abseil Common Libraries (C++)
$(PKG)_WEBSITE  := https://github.com/abseil/abseil-cpp
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 20230125.0
$(PKG)_CHECKSUM := 3ea49a7d97421b88a8c48a0de16c16048e17725c7ec0f1d3ea2683a2a75adc21
$(PKG)_GH_CONF  := abseil/abseil-cpp/releases/latest
$(PKG)_DEPS     := cc
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' -DBUILD_SHARED_LIBS=OFF
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
