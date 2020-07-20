FROM opensuse/tumbleweed

RUN zypper -n ar -c -f -n 'repo-nsis' https://download.opensuse.org/repositories/windows:/mingw:/win32/openSUSE_Tumbleweed/ repo-nsis

RUN zypper --non-interactive --gpg-auto-import-keys ref
RUN zypper --non-interactive --gpg-auto-import-keys dup -l -y

RUN zypper --non-interactive --gpg-auto-import-keys install \
    glibc glibc-extra glibc-locale glibc-i18ndata glibc-32bit gcc-c++ \
    git make cmake libtool pkg-config autoconf automake makeinfo meson ninja intltool \
    which patch wget curl gperf tar gzip bzip2 xz p7zip p7zip-full lzip zip unzip \
    gettext-tools gtk-doc ruby scons bison flex diffutils \
    linux-glibc-devel glibc-devel file-devel libopenssl-devel libffi-devel gdk-pixbuf-devel \
    python-base python3-base python3-setuptools \
    mingw32-cross-nsis

RUN mkdir -p /usr/src
RUN cd /usr/src/ && git clone https://github.com/strawberrymusicplayer/strawberry-mxe
RUN sed -i 's/MXE_TARGETS := .*/MXE_TARGETS := x86_64-w64-mingw32.shared/g' /usr/src/strawberry-mxe/settings.mk
RUN cd /usr/src/strawberry-mxe && make -j4 icu4c
RUN cd /usr/src/strawberry-mxe && make -j4
