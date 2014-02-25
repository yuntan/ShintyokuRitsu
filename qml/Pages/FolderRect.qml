import QtQuick 2.2
import "../Components"

Rectangle {
    id: folRect

    property string folder: ""

    color: "transparent"

    LineLabel {
        anchors {
            top: parent.top
            topMargin: 3*dp
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Folder")
    }

    LineLabel {
        anchors {
            bottom: parent.bottom
            bottomMargin: 3*dp
            horizontalCenter: parent.horizontalCenter
        }
        font.bold: true; font.pointSize: 15
        text: folder !== "" ? folder : qsTr("None")
    }
}
