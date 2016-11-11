TEMPLATE = app

QT += qml quick widgets svg multimedia

SOURCES += src/main.cpp \
    src/carry.cpp \
    src/fileio.cpp \
    src/singleinstance.cpp \
    src/clock.cpp

RESOURCES += qml.qrc images.qrc


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/carry.h \
    src/fileio.h \
    src/singleinstance.h \
    src/clock.h
