# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := faac
$(PKG)_WEBSITE  := http://sourceforge.net/projects/faac/
$(PKG)_DESCR    := Freeware Advanced Audio Coder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.31
$(PKG)_CHECKSUM := 92894e3205ca7fbb0b0d38161ae94c9e884efe5af65886e5ad60eb1a318c78f1
$(PKG)_GH_CONF  := knik0/faac/releases/latest, faac-
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(1)' && ./bootstrap
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' LDFLAGS='-no-undefined'
    $(MAKE) -C '$(1)' -j 1 install LDFLAGS='-no-undefined'
endef
