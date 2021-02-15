# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-markupsafe
$(PKG)_WEBSITE  := https://palletsprojects.com/p/markupsafe
$(PKG)_DESCR    := Safely add untrusted strings to HTML/XML markup
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.0rc1
$(PKG)_CHECKSUM := 05466950097f149d356fbe59aa8e62af0635857cb5c4b4367fea230cb0424a94
$(PKG)_GH_CONF  := pallets/markupsafe/tags,,,a,
$(PKG)_DEPS     := python-conf $(BUILD)~python-setuptools
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    $(PYTHON_SETUP_INSTALL)
endef
