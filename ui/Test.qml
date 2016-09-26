/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/
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
    //color: "transparent"
    property bool lecture : recorder.lecture

    EtaRecorder {
        id: recorder

    }

    onLectureChanged: {
        //console.log("Lecture changed to --> " + test.lecture);
    }
    Text {
        id: text
        text: test.lecture ? "Ders Modu" : "Teneffüs Modu"
        font.family: "OpenSymbol"
        font.bold: true
        //color: "#ffffff"
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
            recorder.lecture = ! recorder.lecture;
            test.lecture = recorder.lecture
        }
    }
    ScrollView {
        id:scrollArea
        anchors.top : btn.bottom

        frameVisible: true
        highlightOnFocus: true
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

    Component.onCompleted: {
        recorder.lecture = true
        test.lecture = recorder.lecture
    }
}
