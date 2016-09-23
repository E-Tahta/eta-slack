import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.recorder 1.0

ApplicationWindow {
    id:test
    visible: true
    x: 1720
    y: 0
    width: 200
    height: 150
    color: "transparent"
    property bool lecture : recorder.lecture

    EtaRecorder {
        id: recorder

    }

    onLectureChanged: {
        console.log("Lecture changed to --> " + test.lecture);
    }
    Text {
        id: text
        text: test.lecture ? "Ders Modu" : "Teneffüs Modu"
        font.family: "OpenSymbol"
        font.bold: true
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12
        anchors {
            horizontalCenter: parent.horizontalCenter
            top:parent.top
        }
    }

    Button {
        id:btn
        anchors.centerIn: parent
        text: test.lecture ? "Dersi Bitir" : "Derse Başla"
        onClicked: {
            console.log("Trying to change lecture");
            recorder.lecture = ! recorder.lecture;
            test.lecture = recorder.lecture
        }
    }
}
