FROM fedora:38

COPY / /strawberry-mxe

RUN dnf update --assumeyes
RUN dnf upgrade --assumeyes
RUN dnf install --assumeyes \
    glibc gcc gcc-c++ \
    shadow which patch gperf wget curl git diffutils \
    make cmake libtool pkg-config autoconf automake meson intltool \
    tar gzip bzip2 xz p7zip lzip zip unzip \
    gtk-doc gettext scons bison flex ruby orc zlib-devel \
    glibc-devel libstdc++-devel file-devel openssl-devel libffi-devel gdk-pixbuf2-devel libzstd-devel pcre2-devel \
    python3 python3-mako \
    mingw32-nsis

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
