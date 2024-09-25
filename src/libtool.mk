# This file is part of MXE. See LICENSE.md for licensing information.

# this pkg is the base for both src/libltdl and plugins/native/libtool
PKG             := libtool
$(PKG)_WEBSITE  := https://www.gnu.org/software/libtool/
$(PKG)_DESCR    := GNU Libtool
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.5.3
$(PKG)_CHECKSUM := 9322bd8f6bc848fda3e385899dd1934957169652acef716d19d19d24053abb95
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ftp.gnu.org/gnu/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ftp.gnu.org/gnu/libtool/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="libtool-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef
