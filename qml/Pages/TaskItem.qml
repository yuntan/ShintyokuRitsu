import QtQuick 2.2
import QtQuick.Layouts 1.1
import "../Components"

Rectangle {
	id: taskItem
	property int id
    property alias name: titleLabel.text
	property bool isProject
	property int importance
    property alias deadline: deadlineLabel.text
    property alias detail: detailLabel.text
    property int percent
    property string folder
	property int projectId

	signal pressed()
	signal pressAndHold()

    height: mainRow.height + 20*dp
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

    RowLayout {
        id: mainRow
        anchors {
            top: parent.top
            left: indicatorCol.right
            right: parent.right
            margins: 10*dp
        }
        spacing: 5*dp
        height: textCol.height

        ColumnLayout {
            id: textCol
            Layout.fillWidth: true
            spacing: 10*dp
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
                color: "red"
            }
        }

        ShintyokuPie {
            id: pie
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
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
        onPressed: taskItem.pressed()
        onPressAndHold: taskItem.pressAndHold()
    }
}
