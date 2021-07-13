# This file is part of MXE. See LICENSE.md for licensing information.

PKG            := qt6-conf
$(PKG)_VERSION  = $(qt6-qtbase_VERSION)
$(PKG)_DEPS    := qt6-qtbase
$(PKG)_TARGETS := $(BUILD) $(MXE_TARGETS)

# ensure conf is also built for a minimal `make qt6base`
qt6base: qt6-conf

QT6_PREFIX   = '$(PREFIX)/$(TARGET)/qt6'
QT6_CMAKE    = '$(QT6_PREFIX)/bin/qt-cmake-private' -DCMAKE_INSTALL_PREFIX='$(QT6_PREFIX)'
QT6_QMAKE    = '$(TARGET)-qt6-qmake'

define $(PKG)_BUILD
    # qmake is a script that calls native qmake with a conf file in its current dir
    (echo '#!/bin/sh'; echo 'exec "$(QT6_PREFIX)/bin/qmake" "$$@"') > '$(PREFIX)/bin/$(TARGET)-qt6-qmake'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-qt6-qmake'
endef

define $(PKG)_BUILD_$(BUILD)
endef
