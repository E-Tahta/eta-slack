import QtQuick 2.3
import QtQuick.Controls 1.2
import QtMultimedia 5.0
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
    height: 180
    color: "transparent"

    property int bellAngle: 0
    property int cnt
    property bool lecture: true
    property bool isListOpen : false
    property bool confirm: false

    EtaRecorder {
        id: recorder
    }

    SoundEffect {
        id: sound
        source: "audio/bell.wav"
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
            antialiasing: true
            smooth: true
            mipmap: true
            Text {
                id: txtSlack
                color: "#ffffff"
                width: parent.width
                text: main.lecture ? "Dersi Bitir" : "Derse Başla"
                verticalAlignment: Text.AlignVCenter
                styleColor: "#000000"
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 14

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

                        if (main.lecture) {
                            main.confirm = true
                            openList.start()
                        }

                        else {
                            sound.play()
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
    }

    Rectangle {
        id: listMenu
        width: main.width
        height: 0
        color: "orange"
        radius: 5
        antialiasing: true
        smooth: true


        Item {
            id: containerList

            width: parent.width - 10
            height: parent.height - menuButton.height
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 5

            Text {
                id: txtLegend
                visible: main.isListOpen && !main.confirm ? true : false
                width: parent.width
                text: "Ders\nBaşlangıç\tSon\tTarih"
                font.bold: true
                font.pointSize: 8
            }

            Text {
                id: txtConfirmMessage
                visible: main.isListOpen && main.confirm ? true : false
                width: parent.width
                text: "Dersi bitirmek istediğinize\nemin misiniz?"
                font.bold: true
                font.pointSize: 9
                horizontalAlignment: Text.AlignHCenter
            }


            Flickable {
                visible: main.isListOpen && !main.confirm ? true : false
                anchors.top: txtLegend.bottom
                anchors.margins: 12
                height: main.height - txtLegend.height - menuButton.height - 12
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

            Rectangle {
                id: btnConfirm
                visible: main.isListOpen && main.confirm ? true : false
                width: parent.width
                anchors.margins: 10
                anchors.top: txtConfirmMessage.bottom
                height: 45
                color: "green"
                radius: 10
                Text {
                    id: txtConfirm
                    text: "Evet"
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea {
                    id: maConfirm
                    anchors.fill: parent
                    onClicked: {
                        main.confirm = false
                        closeList.start()
                        sound.play()
                        recorder.lecture = ! recorder.lecture;
                        main.lecture = recorder.lecture
                        bellAngle = 45
                        cnt = 8
                        timer.start()
                    }
                }
            }

            Rectangle {
                id: btnCancel
                visible: main.isListOpen && main.confirm ? true : false
                width: parent.width
                height: 45
                anchors.margins: 10
                anchors.top: btnConfirm.bottom
                color: "red"
                radius: 10
                Text {
                    id: txtCancel
                    text: "İptal"
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea {
                    id: maCancel
                    anchors.fill: parent
                    onClicked: {
                        main.confirm = false
                        closeList.start()
                    }
                }
            }

        }
    }

    Rectangle {
        id: menuButton
        color: "orange"
        width: 35; height: 35
        radius: 5
        antialiasing: true
        smooth: true
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
                    if (main.confirm) {
                        main.confirm = false
                    }
                } else {
                    openList.start()
                    list.model = recorder.getList()
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 180; repeat: true;
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
            duration: 180
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: listMenu
            property: "width"
            from: 0
            to: main.width
            duration: 180
            easing.type: Easing.InOutQuad

        }

        NumberAnimation {
            target: listMenu
            property: "x"
            from: main.width / 2
            to: 0
            duration: 180
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
            duration: 180
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {

            target: listMenu
            property: "width"
            from: main.width
            to: 0
            duration: 180
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: listMenu
            property: "x"
            from: 0
            to: main.width / 2
            duration: 180
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

