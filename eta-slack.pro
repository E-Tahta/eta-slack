TEMPLATE = app

QT += qml quick widgets svg

SOURCES += src/main.cpp \
    src/carry.cpp \
    src/fileio.cpp \
    src/clock.cpp

RESOURCES += qml.qrc images.qrc


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/carry.h \
    src/fileio.h \
    src/clock.h
