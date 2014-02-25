import QtQuick 2.2
import "../Components"

Rectangle {
    id: impRect

    property int importance

    color: {
        switch(importance) {
        case 0: return "#ffaaaa"
        case 1: return "#ff8080"
        case 2: return "#ff5555"
        case 3: return "#ff2a2a"
        }
    }

    LineLabel {
        anchors {
            top: parent.top
            topMargin: 3*dp
            horizontalCenter: parent.horizontalCenter
        }
        color: "whitesmoke"
        text: qsTr("Importance")
    }

    LineLabel {
        anchors {
            bottom: parent.bottom
            bottomMargin: 3*dp
            horizontalCenter: parent.horizontalCenter
        }
        color: "whitesmoke"
        font.bold: true; font.pointSize: 15
        text: {
            switch(importance) {
            case 0: return qsTr("Low")
            case 1: return qsTr("Medium")
            case 2: return qsTr("High")
            case 3: return qsTr("Very high")
            }
        }
    }
}

