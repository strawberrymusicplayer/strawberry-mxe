# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := singlecoreapplication
$(PKG)_WEBSITE  := https://github.com/itay-grudev/SingleApplication
$(PKG)_DESCR    := SingleCoreApplication
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.17
$(PKG)_CHECKSUM := 48a0176230186839d11ddb8aefd1db34a78af448a45eb00352d328c314257c53
$(PKG)_GH_CONF  := itay-grudev/SingleApplication/tags
$(PKG)_DEPS     := cc cmake qtbase

define $(PKG)_UPDATE
    echo $(singlecoreapplication_VERSION)
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' -DQAPPLICATION_CLASS="QCoreApplication"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
