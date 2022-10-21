# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faad2
$(PKG)_WEBSITE  := http://faac.sourceforge.net/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.8.8
$(PKG)_CHECKSUM := 985c3fadb9789d2815e50f4ff714511c79c2710ac27a4aaaf5c0c2662141426d
$(PKG)_GH_CONF  := knik0/faad2/releases/latest
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' LDFLAGS='-no-undefined'
    $(MAKE) -C '$(1)' -j 1 install LDFLAGS='-no-undefined'
endef
