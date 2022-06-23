# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.12.0
$(PKG)_CHECKSUM := 2a4f11dce6188b256f3650061525d0fe352069e5c162452818efbbf8d0b5fe1c
$(PKG)_GH_CONF  := google/googletest/tags, release-
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only
