# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := twolame
$(PKG)_WEBSITE  := http://www.twolame.org/
$(PKG)_DESCR    := TwoLAME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.0
$(PKG)_CHECKSUM := cc35424f6019a88c6f52570b63e1baf50f62963a3eac52a03a800bb070d7c87d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/twolame/files/twolame/' | \
    $(SED) -n 's,^.*twolame/\([0-9][^"]*\)/".*,\1,p' | \
    head -n 1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure --host='$(TARGET)' $(MXE_CONFIGURE_OPTS) --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' SUBDIRS=libtwolame
    $(MAKE) -C '$(1)' -j 1 install SUBDIRS=libtwolame
endef
