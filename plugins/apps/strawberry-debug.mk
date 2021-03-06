# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-debug
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 66c60ac
$(PKG)_CHECKSUM := 614e3dba128db277fdf481417569cda5386b890d1c170cb6ab7ef6cf1e7877af
$(PKG)_GH_CONF  := strawberrymusicplayer/strawberry/branches/master
$(PKG)_WEBSITE  := https://www.strawberrymusicplayer.org/
$(PKG)_DEPS     := cc boost protobuf qt5base qt5winextras qt5translations chromaprint gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav taglib libcdio gnutls glib-networking portaudio killproc qtsparkle-qt5

define $(PKG)_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/apps/$(PKG) \
        -DCMAKE_BUILD_TYPE=Debug \
        -DARCH=$(TARGET) \
        -DENABLE_WIN32_CONSOLE=ON \
        -DFORCE_GIT_REVISION="0.8.4-0-g$($(PKG)_VERSION)" \
        -DENABLE_DBUS=OFF \
        -DENABLE_LIBPULSE=OFF \
        -DENABLE_LIBGPOD=OFF \
        -DENABLE_IMOBILEDEVICE=OFF \
        -DENABLE_LIBMTP=OFF \
        -DENABLE_GSTREAMER=ON \
        -DENABLE_VLC=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(INSTALL) '$(SOURCE_DIR)/dist/windows/strawberry.nsi'                         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
    $(INSTALL) '$(SOURCE_DIR)/dist/windows/Capabilities.nsh'                       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
    $(INSTALL) '$(SOURCE_DIR)/dist/windows/FileAssociation.nsh'                    '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
    $(INSTALL) '$(SOURCE_DIR)/dist/windows/strawberry.ico'                         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'

    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/killproc.exe'                              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gdb.exe'                                   '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gst-launch-1.0.exe'                        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gio-modules'
    $(INSTALL) '$(PREFIX)/$(TARGET)/lib/gio/modules/libgiognutls.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gio-modules'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/platforms/qwindows.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/sqldrivers/qsqlite.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qgif.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qjpeg.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qico.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/styles'
    $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/styles/qwindowsvistastyle.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/styles'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstapp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstcoreelements.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioconvert.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiofx.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiomixer.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioparsers.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiorate.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioresample.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiotestsrc.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstautodetect.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstplayback.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstvolume.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstspectrum.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstequalizer.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstreplaygain.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttypefindfunctions.dll' '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstgio.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstdirectsound.dll'       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstwasapi.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstapetag.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsticydemux.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstid3demux.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttaglib.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttcp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstudp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstsoup.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstcdio.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'

    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstflac.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstwavparse.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstwavpack.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstogg.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstvorbis.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstopus.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstopusparse.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstspeex.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstlame.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaiff.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstfaad.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstisomp4.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstasf.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstasfmux.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstlibav.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstpbtypes.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstrtp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstrtsp.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
    $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstfaac.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'

    '$(TOP_DIR)/tools/copydlldeps.sh' -c \
                                          -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins' \
                                          -X '$(PREFIX)/$(TARGET)/apps' \
                                          -R '$(PREFIX)/$(TARGET)';
endef

$(PKG)_BUILD_STATIC =
