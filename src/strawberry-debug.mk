# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := strawberry-debug
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 780e4d3
$(PKG)_CHECKSUM := 0b5cfee005e22a78d537a84b36ba90f665b55c3fc7f2ad11aae793eddc063629
$(PKG)_GH_CONF  := jonaski/strawberry/branches/master
$(PKG)_WEBSITE  := https://www.strawbs.org/
$(PKG)_OWNER    := https://github.com/jonaski
$(PKG)_DEPS     := cc boost protobuf qtbase qtwinextras qttranslations chromaprint gst-plugins-good gst-plugins-bad gst-plugins-ugly xine-lib taglib libcdio gnutls glib-networking

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET)/apps/$(PKG) \
	-DCMAKE_BUILD_TYPE=Debug \
	-DARCH=$(TARGET) \
        -DENABLE_WIN32_CONSOLE=ON \
        -DFORCE_GIT_REVISION="0.6.3-0-g$($(PKG)_VERSION)" \
        -DENABLE_DBUS=OFF \
        -DENABLE_LIBPULSE=OFF \
        -DENABLE_LIBGPOD=OFF \
        -DENABLE_IMOBILEDEVICE=OFF \
        -DENABLE_LIBMTP=OFF \
        -DENABLE_GSTREAMER=ON \
        -DENABLE_XINE=ON \
        -DENABLE_VLC=OFF \
        -DENABLE_PHONON=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_SHARED),

        $(INSTALL) '$(SOURCE_DIR)/dist/windows/strawberry.nsi'                         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
        $(INSTALL) '$(SOURCE_DIR)/dist/windows/Capabilities.nsh'                       '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
        $(INSTALL) '$(SOURCE_DIR)/dist/windows/FileAssociation.nsh'                    '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'
        $(INSTALL) '$(SOURCE_DIR)/dist/windows/strawberry.ico'                         '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin'

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

        #makensis '$(PREFIX)/$(TARGET)/apps/$(PKG)/bin/strawberry.nsi'

    )
endef

$(PKG)_BUILD_STATIC =
