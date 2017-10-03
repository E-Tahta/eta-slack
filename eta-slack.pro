TEMPLATE = app

QT += qml quick widgets svg multimedia

SOURCES += src/main.cpp \
    src/carry.cpp \
    src/fileio.cpp \
    src/singleinstance.cpp \
    src/clock.cpp \
    src/networkmanager.cpp

RESOURCES += qml.qrc images.qrc

HEADERS += \
    src/carry.h \
    src/fileio.h \
    src/singleinstance.h \
    src/clock.h \
    src/networkmanager.h


target.path = /usr/bin/

desktop_file.files = eta-slack.desktop
desktop_file.commands = mkdir -p /etc/xdg/autostart
desktop_file.path = /etc/xdg/autostart/

icon.files = ui/images/bell.svg
icon.commands = mkdir -p /usr/share/eta/eta-slack
icon.path = /usr/share/eta/eta-slack/

INSTALLS += target desktop_file icon



