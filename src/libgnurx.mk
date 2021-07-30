# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libgnurx
$(PKG)_WEBSITE  := https://github.com/jonaski/libgnurx
$(PKG)_DESCR    := regex functionality from glibc extracted into a separate library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := a23e3e1
$(PKG)_CHECKSUM := bdce2246a8755e874b0be90a5bd8cddbc204d6f587e7b10ba9ece07581acc464
$(PKG)_GH_CONF  := jonaski/libgnurx/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./configure --host='$(TARGET)' --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)' $(if $(BUILD_STATIC),install-static,install-shared) TARGET=$(TARGET) bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
