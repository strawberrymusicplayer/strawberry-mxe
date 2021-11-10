# :floppy_disk: MXE (M cross environment) [![License][license-badge]][license-page] ![C/C++ CI](https://github.com/strawberrymusicplayer/strawberry-mxe/workflows/C/C++%20CI/badge.svg)

[license-page]: LICENSE.md
[license-badge]: https://img.shields.io/badge/License-MIT-brightgreen.svg

MXE (M cross environment) is a Makefile that compiles a cross compiler and many free libraries.

This is a modified and minimal version of MXE specifically to build [Strawberry](https://github.com/strawberrymusicplayer/strawberry).
Feel free to make use of it if you need something.

See [MXE](https://github.com/mxe/mxe) for the official and full version.

Some of the libraries here are:

  * GCC 11
  * pthreads
  * Boost
  * CMake
  * Protobuf
  * GLib
  * GStreamer
  * GnuTLS
  * OpenSSL
  * SQLite
  * FFTW
  * Qt 6
  * TagLib
  * Chromaprint
  * Google Test

+ All their dependencies.

Differences from the official repositories:

  * Most of the packages here are on the latest version
  * Up-to-date core packages, GLib, libsoup and pango.
  * Qt 6 has only SQL support for sqlite.
  * GStreamer has only audio specific plugins.
