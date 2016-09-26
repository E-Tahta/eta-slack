import QtQuick 2.3
import QtQuick.Controls 1.2
import eta.recorder 1.0

ApplicationWindow {
    flags:Qt.WindowStaysOnBottomHint |
          Qt.FramelessWindowHint |
          Qt.WindowSystemMenuHint |
          Qt.WindowDoesNotAcceptFocus

    id: main
    visible: true
    x: 300
    y: 100
    width: 250
    height: 200
    color: "transparent"

    property int bellAngle: 0
    property int cnt
    property bool lecture: recorder.lecture
    property bool isListOpen : false

    EtaRecorder {
        id: recorder

    }

    Rectangle {
        id: container
        color: "transparent"
        anchors.centerIn: parent
        width: 80
        height: 120

        Image {
            width: parent.width; height: parent.height
            source: "images/bell.svg"
            Text {
                id: txtSlack
                color: "#ffffff"
                width: parent.width
                text: main.lecture ? "Dersi Bitir" : "Derse Başla"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12

            }
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
                    if (!main.isListOpen){
                        recorder.lecture = ! recorder.lecture;
                        main.lecture = recorder.lecture
                        bellAngle = 45
                        cnt = 8
                        timer.start()
                    }
                }
            }
        }
    }

    Rectangle {
        id: listMenu
        width: main.width
        height: 0
        color: "orange"
        radius: 5

        Item {
            id: containerList
            width: parent.width - 10
            height: parent.height - menuButton.height
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 5

            Text {
                id: txtLegend
                width: parent.width
                visible: main.isListOpen ? true : false
                text: "Ders\nBaşlangıç\tSon\tTarih"
                font.bold: true
                font.pointSize: 8
            }

            Flickable {
                visible: main.isListOpen ? true : false
                anchors.top: txtLegend.bottom
                anchors.margins: 10
                height: main.height - txtLegend.height - menuButton.height - 10
                width: main.width
                ListView {
                    id:list
                    anchors.fill: parent
                    model: recorder.getList()
                    delegate: Text {
                        text:modelData
                    }
                    focus: true
                }
            }
        }
    }

    Rectangle {
        id: menuButton
        color: "orange"
        width: 35; height: 35
        radius: 5
        x: main.width / 2 - menuButton.width / 2
        Text {
            id: txtMenuButton
            color: "white"
            text: isListOpen ? "▲" : "▼"
            anchors.centerIn: parent
        }

        MouseArea {
            id: maMenuButton
            anchors.fill: parent
            onClicked: {
                if (isListOpen) {
                    closeList.start()
                } else {
                    openList.start()
                    list.model = recorder.getList()
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
            target: listMenu
            property: "height"
            from: 0
            to: main.height
            duration: 200
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: listMenu
            property: "width"
            from: 0
            to: main.width
            duration: 200
            easing.type: Easing.InOutQuad

        }

        NumberAnimation {
            target: listMenu
            property: "x"
            from: main.width / 2
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad

        }
        onStopped: isListOpen = true
    }

    ParallelAnimation {
        id: closeList
        NumberAnimation {

            target: listMenu
            property: "height"
            from: main.height
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {

            target: listMenu
            property: "width"
            from: main.width
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: listMenu
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

    Component.onCompleted: {
        recorder.lecture = true
        main.lecture = recorder.lecture
    }
}
