# This file is part of MXE. See LICENSE.md for licensing information.
TEMPLATE = app
TARGET = test-qt6
QT += core widgets network sql
HEADERS += qt-test.hpp
SOURCES += qt-test.cpp
FORMS   += qt-test.ui
RESOURCES += qt-test.qrc
