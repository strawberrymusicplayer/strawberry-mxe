# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-debug
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 65b04ca
$(PKG)_CHECKSUM := 4a66597223b9ca987ef9bee676f6f64aefa74d27097d6f794f72591be726e0f7
$(PKG)_GH_CONF  := jonaski/strawberry/branches/master
$(PKG)_WEBSITE  := https://www.strawbs.org/
$(PKG)_OWNER    := https://github.com/jonaski
$(PKG)_DEPS     := cc boost protobuf qtbase qtwinextras chromaprint liblastfm gst-plugins-good gst-plugins-bad gst-plugins-ugly xine-lib taglib libcdio

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/apps/$(PKG) \
        -DENABLE_WIN32_CONSOLE=ON \
        -DFORCE_GIT_REVISION="0.3.1-0-g$($(PKG)_VERSION)" \
        -DENABLE_DBUS=OFF \
        -DENABLE_LIBGPOD=OFF \
        -DENABLE_IMOBILEDEVICE=OFF \
        -DENABLE_LIBMTP=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_SHARED),

        cp '$(SOURCE_DIR)/dist/windows/strawberry-debug.nsi'                           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/'
        cp '$(SOURCE_DIR)/dist/windows/strawberry-debug-64.nsi'                        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/'
        cp '$(SOURCE_DIR)/dist/windows/Capabilities.nsh'                               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/'
        cp '$(SOURCE_DIR)/dist/windows/FileAssociation.nsh'                            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/'
        cp '$(SOURCE_DIR)/dist/windows/strawberry.ico'                                 '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/'

        ln -s -f '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry-debug.nsi'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry-debug-i686-w64-mingw32.shared.nsi'
        ln -s -f '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry-debug-64.nsi'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry-debug-x86_64-w64-mingw32.shared.nsi'

        $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms'
        $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/platforms/qwindows.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms'
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers'
        $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/sqldrivers/qsqlite.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers'
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
        $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qgif.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
        $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qjpeg.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'
        $(INSTALL) '$(PREFIX)/$(TARGET)/qt5/plugins/imageformats/qico.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats'

        $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstapetag.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstapp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstasf.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaiff.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioconvert.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiofx.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioparsers.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudioresample.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstaudiotestsrc.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstautodetect.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstcoreelements.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstdirectsound.dll'       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstequalizer.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstfaad.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstflac.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstgio.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsticydemux.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstid3demux.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstisomp4.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstlame.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstogg.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstopusparse.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstplayback.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstreplaygain.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstspectrum.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstspeex.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttaglib.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttypefindfunctions.dll' '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstvolume.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstvorbis.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstwavpack.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstwavparse.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstcdio.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgsttcp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstudp.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstsoup.dll'              '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/bin/gstreamer-1.0/libgstlibav.dll'             '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins'

        $(INSTALL) -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_ao_out_directx2.dll'    '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_ao_out_directx.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_dts.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_dvaudio.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_faad.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_gsm610.dll'      '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_lpcm.dll'        '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_mad.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_mpc.dll'         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_decode_mpeg2.dll'       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_dmx_asf.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_dmx_audio.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_dmx_playlist.dll'       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_dmx_slave.dll'          '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_flac.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_wavpack.dll'            '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_xiph.dll'               '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/xineplug_inp_cdda.dll'           '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'

        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_audio_filters.dll' '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_goom.dll'     '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_mosaico.dll'  '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_planar.dll'   '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_switch.dll'   '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_tvtime.dll'   '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'
        $(INSTALL) '$(PREFIX)/$(TARGET)/lib/xine/plugins/2.7/post/xineplug_post_visualizations.dll' '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/xine-plugins'

    '$(TOP_DIR)/tools/copydlldeps.sh' -c \
                                          -d '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/platforms' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/sqldrivers' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/imageformats' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/gstreamer-plugins' \
                                          -F '$(PREFIX)/$(TARGET)/apps/$(PKG)/lib/xine/plugins/2.7' \
                                          -X '$(PREFIX)/$(TARGET)/apps' \
                                          -R '$(PREFIX)/$(TARGET)';

        makensis '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry-debug-$(TARGET).nsi'

    )
endef

$(PKG)_BUILD_STATIC =
