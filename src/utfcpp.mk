# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := utfcpp
$(PKG)_WEBSITE  := https://github.com/nemtrif/utfcpp
$(PKG)_DESCR    := UTF-8 with C++ in a Portable Way
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.5
$(PKG)_CHECKSUM := ffc668a310e77607d393f3c18b32715f223da1eac4c4d6e0579a11df8e6b59cf
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
