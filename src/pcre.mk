# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pcre
$(PKG)_WEBSITE  := https://www.pcre.org/
$(PKG)_DESCR    := Perl Compatible Regular Expressions Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.45
$(PKG)_CHECKSUM := 4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8
$(PKG)_SUBDIR   := pcre-$($(PKG)_VERSION)
$(PKG)_FILE     := pcre-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/pcre/pcre/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/pcre/files/pcre/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD_SHARED
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-utf \
        --enable-pcre16 \
        --enable-pcre32 \
        --enable-unicode-properties \
        --enable-cpp \
        --disable-pcregrep-libz \
        --disable-pcregrep-libbz2 \
        --disable-pcretest-libreadline
    $(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS) dist_html_DATA= dist_doc_DATA=
    $(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_PROGRAMS) dist_html_DATA= dist_doc_DATA=
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man1/pcre*.1
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/pcre*.3
    ln -sf '$(PREFIX)/$(TARGET)/bin/pcre-config' '$(PREFIX)/bin/$(TARGET)-pcre-config'
endef

define $(PKG)_BUILD
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/pcre.h.in'
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/pcreposix.h'
    $($(PKG)_BUILD_SHARED)
endef
