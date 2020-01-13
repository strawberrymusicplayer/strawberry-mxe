# This file is part of MXE. See LICENSE.md for licensing information.

PKG              := meson
$(PKG)_WEBSITE   := https://mesonbuild.com/
$(PKG)_DESCR     := An open source build system meant to be extremely fast and as user friendly as possible.
$(PKG)_IGNORE    :=
$(PKG)_VERSION   := 0.52.1
$(PKG)_CHECKSUM  := ad8dbad61d4c22cb7d768cb1f8a212b4abf0f3fbc17c298d816140ecd9f5d1df
$(PKG)_GH_CONF   := mesonbuild/meson/releases/latest
$(PKG)_SUBDIR    := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE      := $($(PKG)_SUBDIR).tar.gz
$(PKG)_URL       := https://github.com/mesonbuild/meson/archive/$($(PKG)_VERSION).tar.gz
$(PKG)_FILE_DEPS := $(wildcard $(PWD)/src/meson/conf/*)
$(PKG)_DEPS      := cmake-conf ninja python3-conf
$(PKG)_TARGETS  := $(BUILD)

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(SOURCE_DIR)' && python3 setup.py install --prefix='$(PREFIX)/$(TARGET)'

    # Awful hacks: we must hijack the python entry points here to install our
    # site-packages path. This is because Meson is going to put the path to the
    # real python interpreter and script it's been invoked with into the build
    # rules file, bypassing any of our shell wrappers. This causes automatic
    # reconfiguration to fail.

    for prog in meson{,conf,introspect,test} wraptool; do \
        $(SED) '1d' '$(PREFIX)/$(TARGET)'/bin/$${prog} > '$(1)'/$${prog}.tail; \
        echo "#!/usr/bin/env python3" > '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo "__mxe_python_path = r'''" >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo '$(PREFIX)/$(TARGET)/lib/python$(PY3_XY_VER)/site-packages' >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo "'''[1:-1]" >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo 'import sys; sys.path.insert(1, __mxe_python_path)' >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo "__mxe_path = r'''" >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo '$(PREFIX)/$(BUILD)/bin:$(PREFIX)/bin' >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo "'''[1:-1]" >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        echo 'import os; os.environ["PATH"] = "{0}:{1}".format(__mxe_path, os.environ["PATH"])' >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        cat '$(1)'/$${prog}.tail >> '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
        cat '$(PREFIX)/$(TARGET)'/bin/$${prog}; \
    done
endef
