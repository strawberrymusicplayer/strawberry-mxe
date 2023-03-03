# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.13.0
$(PKG)_CHECKSUM := ad7fdba11ea011c1d925b3289cf4af2c66a352e18d4c7264392fead75e919363
$(PKG)_GH_CONF  := google/googletest/releases/latest, v
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only
