FROM opensuse/tumbleweed

COPY / /strawberry-mxe

RUN zypper -n ar -c -f -n 'repo-mingw' https://download.opensuse.org/repositories/windows:/mingw:/win32/openSUSE_Tumbleweed/ repo-mingw

RUN zypper -n --gpg-auto-import-keys ref
RUN zypper -n --gpg-auto-import-keys dup -l -y

RUN zypper -n --gpg-auto-import-keys install \
    glibc glibc-extra glibc-locale glibc-i18ndata glibc-32bit gcc gcc-c++ \
    shadow which patch gperf wget curl git diffutils rsync openssh-clients \
    make cmake libtool pkg-config autoconf automake makeinfo meson ninja intltool \
    tar gzip bzip2 xz p7zip p7zip-full lzip zip unzip \
    gtk-doc gettext-tools scons bison flex ruby orc zlib-devel \
    linux-glibc-devel glibc-devel libstdc++-devel file-devel libopenssl-devel libffi-devel gdk-pixbuf-devel libzstd-devel pcre2-devel \
    python3-base python3-Mako \
    mingw32-cross-nsis

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir -p /tmp/lockedlist && wget https://nsis.sourceforge.io/mediawiki/images/d/d3/LockedList.zip --directory-prefix=/tmp/lockedlist
RUN cd /tmp/lockedlist && unzip /tmp/lockedlist/LockedList.zip
RUN cp /tmp/lockedlist/Plugins/x86-unicode/LockedList.dll /usr/share/nsis/Plugins/x86-unicode/
RUN cp /tmp/lockedlist/Plugins/LockedList64.dll /usr/share/nsis/Plugins/

RUN mkdir -p /tmp/registry && wget https://nsis.sourceforge.io/mediawiki/images/4/47/Registry.zip --directory-prefix=/tmp/registry
RUN cd /tmp/registry && unzip /tmp/registry/Registry.zip
RUN cp /tmp/registry/Desktop/Plugin/registry.dll /usr/share/nsis/Plugins/
RUN cp /tmp/registry/Desktop/Plugin/registry.dll /usr/share/nsis/Plugins/x86-unicode/

RUN mkdir -p /tmp/inetc && wget https://nsis.sourceforge.io/mediawiki/images/c/c9/Inetc.zip --directory-prefix=/tmp/inetc
RUN cd /tmp/inetc && unzip /tmp/inetc/Inetc.zip
RUN cp /tmp/inetc/Plugins/x86-unicode/INetC.dll /usr/share/nsis/Plugins/x86-unicode/

RUN cd strawberry-mxe && make -j 4 MXE_TARGETS="x86_64-w64-mingw32.shared" MXE_BUILD_TYPE="Release" MXE_VERBOSE=1
