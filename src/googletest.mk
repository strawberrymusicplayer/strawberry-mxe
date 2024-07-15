# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := googletest
$(PKG)_WEBSITE  := https://github.com/google/googletest
$(PKG)_DESCR    := Google Test
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.15.0
$(PKG)_CHECKSUM := 7315acb6bf10e99f332c8a43f00d5fbb1ee6ca48c52f6b936991b216c586aaad
$(PKG)_GH_CONF  := google/googletest/releases/latest, v
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_TYPE     := source-only
