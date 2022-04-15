# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pcre2
$(PKG)_WEBSITE  := https://www.pcre.org/
$(PKG)_DESCR    := Perl Compatible Regular Expressions Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.40
$(PKG)_CHECKSUM := 14e4b83c4783933dc17e964318e6324f7cae1bc75d8f3c79bc6969f00c159d68
$(PKG)_GH_CONF  := PhilipHazel/pcre2/releases/latest, pcre2-
$(PKG)_SUBDIR   := pcre2-$($(PKG)_VERSION)
$(PKG)_FILE     := pcre2-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://github.com/PhilipHazel/pcre2/releases/download/$(PKG)-$($(PKG)_VERSION)/$(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_DEPS     := cc

define $(PKG)_BUILD_SHARED
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-unicode \
        --enable-pcre2-16 \
        --enable-pcre2-32 \
        --disable-pcre2grep-libz \
        --disable-pcre2grep-libbz2 \
        --disable-pcre2test-libreadline
    $(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS) dist_html_DATA= dist_doc_DATA=
    $(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_PROGRAMS) dist_html_DATA= dist_doc_DATA=
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man1/pcre*.1
    rm -f '$(PREFIX)/$(TARGET)'/share/man/man3/pcre*.3
    ln -sf '$(PREFIX)/$(TARGET)/bin/pcre2-config' '$(PREFIX)/bin/$(TARGET)-pcre2-config'
endef

define $(PKG)_BUILD
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/src/pcre2.h.in'
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/src/pcre2posix.h'
    $(SED) -i 's,__declspec(dllimport),,' '$(1)/src/pcre2.h.generic'
    $($(PKG)_BUILD_SHARED)
endef
