# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.15.2
$(PKG)_CHECKSUM := 7b42b4d6ed48810c5362c265a17faebe90dc2373c885e5216439d37927f02926
$(PKG)_GH_CONF  := google/googletest/releases/latest, v
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only
