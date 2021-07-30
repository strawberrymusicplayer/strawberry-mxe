# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgnurx
$(PKG)_WEBSITE  := https://github.com/jonaski/libgnurx
$(PKG)_DESCR    := regex functionality from glibc extracted into a separate library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := a3314c3
$(PKG)_CHECKSUM := 474046b4abeceb35aa1f1ebe65324d7e06a7105bf2db2ce4aab2df4b21ec12aa
$(PKG)_GH_CONF  := jonaski/libgnurx/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./configure --host='$(TARGET)' --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)' $(if $(BUILD_STATIC),install-static,install-shared) TARGET=$(TARGET) bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
