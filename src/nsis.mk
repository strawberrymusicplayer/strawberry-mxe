# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nsis
$(PKG)_WEBSITE  := https://nsis.sourceforge.io/
$(PKG)_DESCR    := NSIS
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.10
$(PKG)_CHECKSUM := 11b54a6307ab46fef505b2700aaf6f62847c25aa6eebaf2ae0aab2f17f0cb297
$(PKG)_SUBDIR   := nsis-$($(PKG)_VERSION)-src
$(PKG)_FILE     := nsis-$($(PKG)_VERSION)-src.tar.bz2
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/nsis/NSIS 3/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://nsis.sourceforge.io/Download' | \
    $(SED) -n 's,.*nsis-\([0-9.]\+\)-src.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
    rm -rf '$(PREFIX)/$(TARGET)/share/nsis'
    $(SED) -i 's/m_target_type=.*/$(if $(findstring x86_64-w64,$(TARGET)), m_target_type=TARGET_AMD64;/,m_target_type=TARGET_X86UNICODE;/)' '$(SOURCE_DIR)/Source/build.cpp'
    cd '$(SOURCE_DIR)' && PATH='$(PREFIX)/bin:$(PATH)' scons \
        TARGET_ARCH=$(if $(findstring x86_64,$(TARGET)),amd64,x86) \
        LINKFLAGS="--oformat pei-$(if $(findstring x86_64,$(TARGET)),x86-64,i386)" \
        XGCC_W32_PREFIX='$(TARGET)-' \
        PREFIX='$(PREFIX)/$(TARGET)' \
        NSIS_MAX_STRLEN=8192 \
        SKIPUTILS='MakeLangId,Makensisw,zip2exe' \
        -j 1 install

    $(INSTALL) -m755 '$(PREFIX)/$(TARGET)/bin/makensis' '$(PREFIX)/bin/$(TARGET)-makensis'
    '$(TARGET)-makensis' -version
endef
