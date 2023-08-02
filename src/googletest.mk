# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.14.0
$(PKG)_CHECKSUM := 8ad598c73ad796e0d8280b082cebd82a630d73e73cd3c70057938a6501bba5d7
$(PKG)_GH_CONF  := google/googletest/releases/latest, v
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only
