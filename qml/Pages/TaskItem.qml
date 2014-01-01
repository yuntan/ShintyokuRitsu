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
			topMargin: 1.*mm
			bottom: parent.bottom
			bottomMargin: 1.*mm
			left: parent.left
		}
		width: 3.*mm
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
			margins: 2.*mm
		}
		spacing: 1.*mm

		ColumnLayout {
			id: textCol
			Layout.fillWidth: true; Layout.fillHeight: true
			spacing: 2.*mm
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
			leftMargin: 4.*mm
			right: parent.right
			rightMargin: 4.*mm
		}
		height: 2
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
