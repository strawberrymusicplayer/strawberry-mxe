# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-setuptools
$(PKG)_WEBSITE  := https://pypi.org/project/setuptools
$(PKG)_DESCR    := Easily download, build, install, upgrade, and uninstall Python packages
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 53.0.0
$(PKG)_CHECKSUM := 11ef43496d5b59e17d2c3ff961f587ea002d595b0add32f77e035dd8c2e36fa5
$(PKG)_GH_CONF  := pypa/setuptools/releases, v
$(PKG)_DEPS     := python-conf
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(BUILD)-python$(PY_XY_VER) bootstrap.py
    $(PYTHON_SETUP_INSTALL)
endef
