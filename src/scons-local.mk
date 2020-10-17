# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := scons-local
$(PKG)_WEBSITE  := https://scons.org/
$(PKG)_DESCR    := Standalone SCons
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.1
$(PKG)_CHECKSUM := 23c9d37a008b525bdedfe2666a28b9466c4c945d8ba379873cfd0b9006a3d618
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
SCONS_LOCAL = PATH='$(PREFIX)/bin:$(PATH)' python3 '$(BUILD_DIR).scons/scons.py'
