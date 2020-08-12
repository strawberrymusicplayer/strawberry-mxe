# This file is part of MXE. See LICENSE.md for licensing information.
TEMPLATE = app
greaterThan(QT_MAJOR_VERSION, 5): TARGET = test-qt6
else: TARGET = test-qt5
QT += core widgets network sql
HEADERS += qt-test.hpp
SOURCES += qt-test.cpp
FORMS   += qt-test.ui
RESOURCES += qt-test.qrc
