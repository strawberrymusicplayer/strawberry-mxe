# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-setuptools
$(PKG)_WEBSITE  := https://pypi.org/project/setuptools
$(PKG)_DESCR    := Easily download, build, install, upgrade, and uninstall Python packages
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 51.3.3
$(PKG)_CHECKSUM := 8e45c6cb18f81842421560f788521842572a91a0e64419e338a6a15828ccf076
$(PKG)_GH_CONF  := pypa/setuptools/releases, v
$(PKG)_DEPS     := python-conf
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(BUILD)-python$(PY_XY_VER) bootstrap.py
    $(PYTHON_SETUP_INSTALL)
endef
