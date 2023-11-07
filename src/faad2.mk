# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faad2
$(PKG)_WEBSITE  := http://faac.sourceforge.net/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.11.0
$(PKG)_CHECKSUM := 720c1dc404439e0a9117aa144dc7ead56f1658adf4badbb39f959d6ad8eed489
$(PKG)_GH_CONF  := knik0/faad2/releases/latest
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
