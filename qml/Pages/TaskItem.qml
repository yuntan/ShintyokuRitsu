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
	property string tag
	property int projectId

	signal pressed()
	signal pressAndHold()

	width: parent.width; height: mainRow.height
	color: "transparent"

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
				case 0: color = "white"; break
				case 1: color = "red"; break
				case 2: color = "red"; break
				case 3: color = "red"; break
				}
			}
		}

		Rectangle {
			id: tagRect
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

		ColumnLayout {
			id: textCol
			Layout.fillWidth: true; Layout.fillHeight: true
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
			Item { Layout.fillHeight: true }
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
		anchors.fill: parent
		onPressed: taskItem.pressed()
		onPressAndHold: taskItem.pressAndHold()
		onPressedChanged: {
			if(pressed) { taskItem.color = "#80000000" }
			else { taskItem.color = "transparent" }
		}
	}
}
