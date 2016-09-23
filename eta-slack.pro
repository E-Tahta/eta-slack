TEMPLATE = app

QT += qml quick widgets

SOURCES += src/main.cpp \
    src/carry.cpp \
    src/fileio.cpp

RESOURCES += qml.qrc


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/carry.h \
    src/fileio.h
