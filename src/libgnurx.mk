# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgnurx
$(PKG)_WEBSITE  := https://github.com/jonaski/libgnurx
$(PKG)_DESCR    := regex functionality from glibc extracted into a separate library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := ce50f3c
$(PKG)_CHECKSUM := 11c088a2638764650ba5f5c8de752c8440f2a27fbfeb600ddd1e69988c37556f
$(PKG)_GH_CONF  := jonaski/libgnurx/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./configure --host='$(TARGET)' --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)' $(if $(BUILD_STATIC), install-static, install-shared) TARGET=$(TARGET) bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
