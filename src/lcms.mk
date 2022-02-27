# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lcms
$(PKG)_WEBSITE  := http://www.littlecms.com/
$(PKG)_DESCR    := Little cms color engine
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.13
$(PKG)_CHECKSUM := 0c67a5cc144029cfa34647a52809ec399aae488db4258a6a66fba318474a070f
$(PKG)_SUBDIR   := $(PKG)$(word 1,$(subst ., ,$($(PKG)_VERSION)))-$(subst a,,$($(PKG)_VERSION))
$(PKG)_FILE     := $(PKG)$(word 1,$(subst ., ,$($(PKG)_VERSION)))-$(subst a,,$($(PKG)_VERSION)).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/$(subst a,,$($(PKG)_VERSION))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc jpeg tiff zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/lcms/files/lcms/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --with-zlib --with-jpeg --with-tiff
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=
endef
