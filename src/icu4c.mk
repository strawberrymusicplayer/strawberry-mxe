# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := icu4c
$(PKG)_WEBSITE  := https://icu.unicode.org/
$(PKG)_DESCR    := ICU4C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 77.1
$(PKG)_MAJOR    := $(word 1,$(subst ., ,$($(PKG)_VERSION)))
$(PKG)_CHECKSUM := 588e431f77327c39031ffbb8843c0e3bc122c211374485fa87dc5f3faff24061
$(PKG)_GH_CONF  := unicode-org/icu/releases/latest,release-,,,-
$(PKG)_SUBDIR   := icu/source
$(PKG)_URL      := https://github.com/unicode-org/icu/releases/download/release-$(subst .,-,$($(PKG)_VERSION))/icu4c-$(subst .,_,$($(PKG)_VERSION))-src.tgz
$(PKG)_DEPS     := cc $(BUILD)~$(PKG)

$(PKG)_TARGETS       := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD_$(BUILD)

    # cross build requires artefacts from native build tree
    rm -rf '$(PREFIX)/$(BUILD)/$(PKG)'
    $(INSTALL) -d '$(PREFIX)/$(BUILD)/$(PKG)'
    cd '$(PREFIX)/$(BUILD)/$(PKG)' && '$(SOURCE_DIR)/configure' CC=$(BUILD_CC) CXX=$(BUILD_CXX) --enable-tests=no --enable-samples=no
    $(MAKE) -C '$(PREFIX)/$(BUILD)/$(PKG)' -j '$(JOBS)'

endef

define $(PKG)_BUILD_COMMON

    rm -fv $(shell echo "$(PREFIX)/$(TARGET)"/{bin,lib}/{lib,libs,}icu'*'.{a,dll,dll.a})
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' $(MXE_CONFIGURE_OPTS) --with-cross-build='$(PREFIX)/$(BUILD)/$(PKG)' --enable-icu-config=no SHELL=$(SHELL) CXXFLAGS='-std=gnu++17' LIBS='-lstdc++' $($(PKG)_CONFIGURE_OPTS)

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' VERBOSE=1 SO_TARGET_VERSION_SUFFIX=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install VERBOSE=1 SO_TARGET_VERSION_SUFFIX=

endef

define $(PKG)_BUILD_TEST
    '$(TARGET)-gcc' -W -Wall -Werror -ansi -pedantic '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' `'$(TARGET)-pkg-config' icu-uc icu-io icu-i18n --cflags --libs`
endef

define $(PKG)_BUILD_SHARED
    $($(PKG)_BUILD_COMMON)

    # stub data is icudt.dll, actual data is libicudt.dll - prefer actual
    test ! -e '$(PREFIX)/$(TARGET)/lib/libicudt$($(PKG)_MAJOR).dll' || mv -fv '$(PREFIX)/$(TARGET)/lib/libicudt$($(PKG)_MAJOR).dll' '$(PREFIX)/$(TARGET)/bin/icudt$($(PKG)_MAJOR).dll'

    $($(PKG)_BUILD_TEST)
endef

define $(PKG)_BUILD
    $($(PKG)_BUILD_COMMON)
    $($(PKG)_BUILD_TEST)
endef
