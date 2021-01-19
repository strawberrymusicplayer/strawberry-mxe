# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := scons-local
$(PKG)_WEBSITE  := https://scons.org/
$(PKG)_DESCR    := Standalone SCons
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.0
$(PKG)_CHECKSUM := dae328bd95d1dc30f963b9ac2adc8a455b43227b7e7aa442f94c0270120e1ccb
$(PKG)_SUBDIR   := .
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/scons/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
$(PKG)_DEPS     :=

define $(PKG)_UPDATE
    $(call GET_LATEST_VERSION, https://scons.org/pages/download.html,scons-local-)
endef

# unpack sources into build dir and execute directly with python2
# scons does various PATH manipulations that don't play well with ccache
SCONS_LOCAL = PATH='$(PREFIX)/bin:$(PATH)' $(BUILD)-python$(PY_XY_VER) '$(BUILD_DIR).scons/scons.py'
SCONS_PREP = \
    mkdir -p '$(BUILD_DIR).scons' && \
    $(call PREPARE_PKG_SOURCE,scons-local,'$(BUILD_DIR).scons')
