import QtQuick 2.2
import QtQuick.Layouts 1.1
import "../Components"

Rectangle {
	id: taskItem

    property int taskId
    property alias name: titleLabel.text
	property bool isProject
	property int importance
    property date deadline: undefined
    property alias detail: detailLabel.text
    property alias percent: pie.percent
    property string folder
	property int projectId

    signal clicked()
	signal pressAndHold()

    height: textCol.height + 20*dp
    color: mouse.pressed ? "#40000000" : "transparent"

    ColumnLayout {
        id: indicatorCol
        anchors {
            top: parent.top
            topMargin: 5*dp
            bottom: parent.bottom
            bottomMargin: 5*dp
            left: parent.left
        }
        width: 15*dp
        spacing: 0

        Rectangle {
            id: importanceRect
            Layout.fillWidth: true
            Layout.preferredHeight: width
            Component.onCompleted: {
                switch(importance) {
                case 0: color = "#ffaaaa"; break
                case 1: color = "#ff8080"; break
                case 2: color = "#ff5555"; break
                case 3: color = "#ff2a2a"; break
                }
            }
        }

        Rectangle {
            id: folderRect
            Layout.fillWidth: true; Layout.fillHeight: true
            color: "white"
        }
    }

    ColumnLayout {
        id: textCol
        anchors {
            top: parent.top
            left: indicatorCol.right
            right: pie.left
            margins: 10*dp
        }
        spacing: 5*dp
        LineLabel {
            id: titleLabel
            Layout.fillWidth: true
            font.bold: true
            font.pointSize: 15
        }
        LineLabel {
            id: detailLabel
            Layout.fillWidth: true
            font.pointSize: 12
        }
        LineLabel {
            id: deadlineLabel
            Layout.fillWidth: true
            color: deadline != undefined ? "red" : "#666666"
            text: deadline != undefined
                  ? "Deadline: " + deadline.getDate()
                  : "no deadline"
        }
    }

    ShintyokuPie {
        id: pie
        width: height
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            margins: 5*dp
        }
    }

    Rectangle {
        id: bottomLine
        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 20*dp
            right: parent.right
            rightMargin: 20*dp
        }
        height: 2*dp
        color: "#666666"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: taskItem.clicked()
        onPressAndHold: taskItem.pressAndHold()
    }
}
