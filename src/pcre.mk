# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pcre
$(PKG)_WEBSITE  := https://www.pcre.org/
$(PKG)_DESCR    := PCRE
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.42
$(PKG)_CHECKSUM := 2cd04b7c887808be030254e8d77de11d3fe9d4505c39d4b15d2664ffe8bf9301
$(PKG)_SUBDIR   := pcre-$($(PKG)_VERSION)
$(PKG)_FILE     := pcre-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://ftp.pcre.org/pub/pcre/$($(PKG)_FILE)
$(PKG)_URL_2    := https://$(SOURCEFORGE_MIRROR)/project/pcre/pcre/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    echo 'TODO: Updates for package $(PKG) need to be written.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'https://ftp.pcre.org/pub/pcre/' | \
#    $(SED) -n 's,.*/\([0-9][^"]*\)/".*,\1,p' | \
#    head -1
#endef

define $(PKG)_BUILD_SHARED
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-pcre16 \
        --enable-utf \
        --enable-unicode-properties \
        --enable-cpp \
        --disable-pcregrep-libz \
        --disable-pcregrep-libbz2 \
        --disable-pcretest-libreadline
    $(MAKE) -C '$(1)' -j '$(JOBS)' install $(MXE_DISABLE_PROGRAMS) dist_html_DATA= dist_doc_DATA=
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man1/pcre*.1
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/pcre*.3
    ln -sf '$(PREFIX)/$(TARGET)/bin/pcre-config' '$(PREFIX)/bin/$(TARGET)-pcre-config'
endef

define $(PKG)_BUILD
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/pcre.h.in'
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/pcreposix.h'
    $($(PKG)_BUILD_SHARED)
endef
