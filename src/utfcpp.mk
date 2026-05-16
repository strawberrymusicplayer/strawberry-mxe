# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := utfcpp
$(PKG)_WEBSITE  := https://github.com/nemtrif/utfcpp
$(PKG)_DESCR    := UTF-8 with C++ in a Portable Way
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.0
$(PKG)_CHECKSUM := 9a45cbeefacf512879971eaf57fe52133b73a0152d5354f3adeaf8d103cff0f3
$(PKG)_GH_CONF  := nemtrif/utfcpp/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
