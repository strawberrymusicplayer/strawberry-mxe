# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fribidi
$(PKG)_WEBSITE  := https://fribidi.org/
$(PKG)_DESCR    := FriBidi
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.7
$(PKG)_CHECKSUM := 5ab5f21e9f2fc57b4b40f8ea8f14dba78a5cc46d9cf94bc5e00a58e6886a935d
$(PKG)_GH_CONF  := fribidi/fribidi/releases, v, , , , .tar.bz2
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-debug \
        --disable-deprecated \
        $(if $(BUILD_STATIC), \
            --enable-static )
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= dist_man_MANS=
endef
