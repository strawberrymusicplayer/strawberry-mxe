# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-setuptools
$(PKG)_WEBSITE  := https://pypi.org/project/setuptools
$(PKG)_DESCR    := Easily download, build, install, upgrade, and uninstall Python packages
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 51.1.2
$(PKG)_CHECKSUM := 1f3db173c1d8f8753dce0b6c18017955863fc39a0613e5c20bfdd107f331fafb
$(PKG)_GH_CONF  := pypa/setuptools/releases, v
$(PKG)_DEPS     := python-conf
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(BUILD)-python$(PY_XY_VER) bootstrap.py
    $(PYTHON_SETUP_INSTALL)
endef
