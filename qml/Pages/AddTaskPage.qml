import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "../Components"
import "../../js/Storage.js" as JS

Page {
	id: addTaskPage
	title: qsTr("Add Task")

	ScrollView {
		anchors.fill: parent
		flickableItem.interactive: true
		flickableItem.flickableDirection: Flickable.VerticalFlick

		ColumnLayout {
			id: mainCol
			anchors {
				fill: parent
				margins: 3.*mm
			}
			spacing: 3.*mm

			LineEdit {
				id: nameEdit
				Layout.fillWidth: true
				onTextChanged: {
					if(text === "") { addTaskPage.title = qsTr("Add Task") }
					else { addTaskPage.title = text }
				}
			}

			BoxEdit {
				id: detailEdit
				Layout.fillWidth: true
				Layout.preferredHeight: 30.*mm
			}

			LineEdit {
				id: deadlineEdit
				Layout.fillWidth: true
			}

			LineEdit {
				id: targetTimeEdit
				Layout.fillWidth: true
			}

			Slider {

			}
		}
	}
}
