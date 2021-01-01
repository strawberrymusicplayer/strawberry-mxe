# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-setuptools
$(PKG)_WEBSITE  := https://pypi.org/project/setuptools
$(PKG)_DESCR    := Easily download, build, install, upgrade, and uninstall Python packages
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 51.1.1
$(PKG)_CHECKSUM := 97434f60d427e33cbcbd69003a20596f66a8643079858a8768574a8b73a97dbd
$(PKG)_GH_CONF  := pypa/setuptools/releases, v
$(PKG)_DEPS     := python-conf
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(BUILD)-python$(PY_XY_VER) bootstrap.py
    $(PYTHON_SETUP_INSTALL)
endef
