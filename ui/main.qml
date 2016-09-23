import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    flags:Qt.WindowStaysOnBottomHint |
          Qt.FramelessWindowHint |
          Qt.WindowSystemMenuHint |
          Qt.WindowDoesNotAcceptFocus

    id: main
    visible: true
    x: 300
    y: 100
    width: 200
    height: 200
    color: "transparent"

    property int bellAngle: 0
    property int cnt
    property bool active: true
    property bool isListOpen : false

    Rectangle {
        id: container
        //color: active ? "transparent" : "red"
        color: "transparent"
        anchors.centerIn: parent
        width: 80
        height: 120

        Image {
            width: parent.width; height: parent.height
            source: "images/bell.svg"
            transform: Rotation {
                id: bell
                origin.x: container.width / 2; origin.y: 0;
                angle: bellAngle
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }

            MouseArea {
                id: maBell
                anchors.fill: parent
                onClicked: {
                    bellAngle = 45
                    cnt = 8
                    active = !active
                    timer.start()
                }
            }
        }
    }

    Rectangle {
        id: list
        width: main.width
        height: 0
        color: "orange"
        radius: 5
    }

    Rectangle {
        id: menu
        color: "orange"
        width: 30; height: 30
        radius: 5
        x: main.width / 2 - menu.width / 2
        Text {
            id: txtMenu
            text: isListOpen ? "▲" : "▼"
            anchors.centerIn: parent
        }

        MouseArea {
            id: maMenu
            anchors.fill: parent
            onClicked: {
                if (isListOpen) {
                    closeList.start()
                } else {
                    openList.start()
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 200; repeat: true;
        onTriggered: {
            ringBell()
        }
    }

    ParallelAnimation {
        id: openList
        NumberAnimation {
            target: list
            property: "height"
            from: 0
            to: main.height
            duration: 200
            easing.type: Easing.InOutQuad

        }
        NumberAnimation {
            target: list
            property: "width"
            from: 0
            to: main.width
            duration: 200
            easing.type: Easing.InOutQuad

        }

        NumberAnimation {
            target: list
            property: "x"
            from: main.width / 2
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad

        }
        onStarted: isListOpen = true
    }

    ParallelAnimation {
        id: closeList
        NumberAnimation {

            target: list
            property: "height"
            from: main.height
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad

        }

        NumberAnimation {

            target: list
            property: "width"
            from: main.width
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad

        }

        NumberAnimation {
            target: list
            property: "x"
            from: 0
            to: main.width / 2
            duration: 200
            easing.type: Easing.InOutQuad

        }
        onStarted: isListOpen = false
    }

    function ringBell() {
        if (main.cnt > 0) {
            main.cnt--
            bellAngle = 0 - bellAngle
        } else {
            timer.stop()
            bellAngle = 0
        }
    }
}
