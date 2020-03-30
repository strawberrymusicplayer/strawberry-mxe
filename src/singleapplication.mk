# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := singleapplication
$(PKG)_WEBSITE  := https://github.com/itay-grudev/SingleApplication
$(PKG)_DESCR    := SingleApplication
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.0a
$(PKG)_CHECKSUM := 620908325070fda4ef1245054ce1bb6c8a813bd3ffb5cf9c6251dfb9dee266b4
$(PKG)_GH_CONF  := itay-grudev/SingleApplication/tags, v
$(PKG)_DEPS     := cc qtbase

# The patch breaks changes all the time so just disable updating.
define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DQAPPLICATION_CLASS="QApplication"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
