# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := python-mako
$(PKG)_WEBSITE  := https://www.makotemplates.org
$(PKG)_DESCR    := Mako Templates for Python
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.4
$(PKG)_CHECKSUM := 21a46722e5b54a0e02c6d09e3b353f025975b7da7a4a4f25d6813d84be452168
$(PKG)_GH_CONF  := sqlalchemy/mako/tags,rel_,,,_
$(PKG)_DEPS     := python-conf $(BUILD)~python-markupsafe
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_BUILD
    $(PYTHON_SETUP_INSTALL)
endef
