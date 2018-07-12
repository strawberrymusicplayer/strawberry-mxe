# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
#$(PKG)_VERSION  := 1.8.0
#$(PKG)_CHECKSUM := 58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8
$(PKG)_VERSION  := 1.7.0
$(PKG)_CHECKSUM := f73a6546fdf9fce9ff93a5015e0333a8af3062a152a9ad6bcb772c96687016cc
$(PKG)_GH_CONF  := google/googletest/tags, release-
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef
