# This file is part of MXE. See LICENSE.md for licensing information.

# this pkg is the base for both src/libltdl and plugins/native/libtool
PKG             := libtool
$(PKG)_WEBSITE  := https://www.gnu.org/software/libtool/
$(PKG)_DESCR    := GNU Libtool
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.6.2
$(PKG)_CHECKSUM := 24adb3aa9ae035c70faba344af57d73215eb89281045af6c7ccd307751f8b0bf
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://gnuftp.uib.no/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     :=
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gnuftp.uib.no/libtool/?C=M;O=D' | \
    $(SED) -n 's,.*<a href="libtool-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef
