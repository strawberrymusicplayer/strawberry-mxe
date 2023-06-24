# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := freetype
$(PKG)_WEBSITE  := https://www.freetype.org/
$(PKG)_DESCR    := FreeType is a freely available software library to render fonts
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.13.1
$(PKG)_CHECKSUM := ea67e3b019b1104d1667aa274f5dc307d8cbd606b399bc32df308a77f1a564bf
$(PKG)_SUBDIR   := freetype-$($(PKG)_VERSION)
$(PKG)_FILE     := freetype-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/freetype/freetype2/$(shell echo '$($(PKG)_VERSION)' | cut -d . -f 1,2,3)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-conf zlib bzip2 brotli libpng harfbuzz

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/freetype/files/freetype2/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD_COMMON

    cd '$(SOURCE_DIR)' && \
        LIBPNG_CFLAGS="`$(TARGET)-pkg-config libpng --cflags`" \
        LIBPNG_LDFLAGS="`$(TARGET)-pkg-config libpng --libs`" \
        FT2_EXTRA_LIBS="`$(TARGET)-pkg-config libpng --libs`" \
        $(if $(BUILD_STATIC),HARFBUZZ_LIBS="`$(TARGET)-pkg-config harfbuzz --libs` -lharfbuzz_too -lfreetype_too `$(TARGET)-pkg-config glib-2.0 --libs`",) \
        '$(TARGET)-meson' \
        --buildtype='$(MESON_BUILD_TYPE)' \
        -Dzlib=enabled \
        -Dbzip2=enabled \
        -Dbrotli=enabled \
        -Dpng=enabled \
        -Dharfbuzz=enabled \
        -Dtests=disabled \
        '$(BUILD_DIR)'

    cd '$(BUILD_DIR)' && ninja
    cd '$(BUILD_DIR)' && ninja install

    ln -sf '$(PREFIX)/$(TARGET)/bin/freetype-config' '$(PREFIX)/bin/$(TARGET)-freetype-config'

endef

define $(PKG)_BUILD
    # Alias libharfbuzz and libfreetype to satisfy circular dependence libfreetype should already have been created by freetype-bootstrap.mk
    $(if $(BUILD_STATIC), ln -sf libharfbuzz.a '$(PREFIX)/$(TARGET)/lib/libharfbuzz_too.a' && ln -sf libfreetype.a '$(PREFIX)/$(TARGET)/lib/libfreetype_too.a',)
    $($(PKG)_BUILD_COMMON)
endef
