PKG             := glib-networking
$(PKG)_WEBSITE  := https://www.gnome.org
$(PKG)_DESCR    := Network-related GIO modules for glib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.54.1
$(PKG)_CHECKSUM := eaa787b653015a0de31c928e9a17eb57b4ce23c8cf6f277afaec0d685335012f
$(PKG)_SUBDIR   := glib-networking-$($(PKG)_VERSION)
$(PKG)_FILE     := glib-networking-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc gnutls

define $(PKG)_UPDATE
    echo 'Updates for package $(PKG) is disabled.' >&2;
    echo $($(PKG)_VERSION)
endef

#define $(PKG)_UPDATE
#   $(WGET) -q -O- 'https://git.gnome.org/browse/glib-networking/refs/tags' | \
#    grep '<a href=' | \
#    $(SED) -n 's,.*<a[^>]*>\([0-9]*\.[0-9]*[02468]\.[^<]*\)<.*,\1,p' | \
#    sort -Vr | \
#    head -1
#endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
	$(subst docdir$(comma),,$(MXE_CONFIGURE_OPTS))
    $(MAKE) -C '$(1)'
    $(MAKE) -C '$(1)' install
endef
