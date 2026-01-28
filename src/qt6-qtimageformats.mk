PKG             := qt6-qtimageformats
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt 6 Imageformats
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.10.2
$(PKG)_CHECKSUM := 8b8f9c718638081e7b3c000e7f31910140b1202a98e98df5d1b496fe6f639d67
$(PKG)_FILE     := qtimageformats-everywhere-src-$($(PKG)_VERSION).tar.xz
$(PKG)_SUBDIR   := qtimageformats-everywhere-src-$($(PKG)_VERSION)
$(PKG)_URL      := https://download.qt.io/official_releases/qt/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_VERSION)/submodules/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc qt6-qtbase jasper libwebp tiff

$(PKG)_UPDATE = $(qt6-qtbase_UPDATE)

define $(PKG)_BUILD
    $(QT6_CMAKE) --log-level="DEBUG" -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_BUILD_TYPE='$(MXE_BUILD_TYPE)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DFEATURE_jasper=ON \
        -DFEATURE_tiff=ON \
        -DFEATURE_webp=ON \
        -DFEATURE_system_tiff=OFF \
        -DFEATURE_system_webp=ON
    cmake --build '$(BUILD_DIR)' -j '$(JOBS)'
    cmake --install '$(BUILD_DIR)'
endef
