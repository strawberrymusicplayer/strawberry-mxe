# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := singleapplication
$(PKG)_WEBSITE  := https://github.com/itay-grudev/SingleApplication
$(PKG)_DESCR    := SingleApplication
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.19
$(PKG)_CHECKSUM := 9405fd259288b2a862e91e5135bccee936f0438e1b32c13603277132309d15e0
$(PKG)_GH_CONF  := itay-grudev/SingleApplication/tags, v
$(PKG)_DEPS     := cc qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DQAPPLICATION_CLASS="QApplication"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
