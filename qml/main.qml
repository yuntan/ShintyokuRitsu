import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

ApplicationWindow {
		width: 360
		height: 360

	Rectangle {
		anchors.fill: parent
		Text {
			text: qsTr("Hello World")
			anchors.centerIn: parent
		}
		MouseArea {
			anchors.fill: parent
			onClicked: {
				Qt.quit();
			}
		}
	}
}
