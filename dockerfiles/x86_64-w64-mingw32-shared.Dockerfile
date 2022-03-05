FROM opensuse/leap:15.3

RUN zypper -n ar -c -f -n 'repo-devel-tools-building' https://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_15.3/ repo-devel-tools-building
RUN zypper -n ar -c -f -n 'repo-mingw' https://download.opensuse.org/repositories/windows:/mingw:/win32/openSUSE_Leap_15.3/ repo-mingw

RUN zypper -n --gpg-auto-import-keys ref
RUN zypper -n --gpg-auto-import-keys up -l -y

RUN zypper -n --gpg-auto-import-keys install \
    glibc glibc-extra glibc-locale glibc-i18ndata glibc-32bit gcc11 gcc11-c++ \
    shadow which patch gperf wget curl git diffutils \
    make cmake libtool pkg-config autoconf automake makeinfo meson ninja intltool \
    tar gzip bzip2 xz p7zip p7zip-full lzip zip unzip \
    gtk-doc gettext-tools scons bison flex ruby orc zlib-devel \
    linux-glibc-devel glibc-devel file-devel libopenssl-devel libffi-devel gdk-pixbuf-devel libzstd-devel \
    python3-base python3-Mako \
    mingw32-cross-nsis

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-11 50
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-11 50
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 50
RUN update-alternatives --set cc /usr/bin/gcc-11
RUN update-alternatives --set c++ /usr/bin/g++-11
RUN update-alternatives --set gcc /usr/bin/gcc-11
RUN update-alternatives --set g++ /usr/bin/g++-11

RUN ln -s /usr/bin/python3 /usr/bin/python

# Patch meson
RUN cd /tmp && wget https://patch-diff.githubusercontent.com/raw/mesonbuild/meson/pull/9841.patch
RUN cd /usr/lib/python3.6/site-packages && patch -p1 < /tmp/9841.patch

RUN mkdir -p /tmp/lockedlist && wget https://nsis.sourceforge.io/mediawiki/images/d/d3/LockedList.zip --directory-prefix=/tmp/lockedlist
RUN cd /tmp/lockedlist && unzip /tmp/lockedlist/LockedList.zip
RUN cp /tmp/lockedlist/Plugins/x86-unicode/LockedList.dll /usr/share/nsis/Plugins/x86-unicode/
RUN cp /tmp/lockedlist/Plugins/LockedList64.dll /usr/share/nsis/Plugins/

RUN mkdir -p /usr/src
RUN cd /usr/src/ && git clone https://github.com/strawberrymusicplayer/strawberry-mxe
RUN sed -i 's/MXE_TARGETS := .*/MXE_TARGETS := x86_64-w64-mingw32.shared/g' /usr/src/strawberry-mxe/settings.mk
RUN cd /usr/src/strawberry-mxe && make -j4 || { cat $(ls -1t log/*-* | head -n 1) && exit 1; }
