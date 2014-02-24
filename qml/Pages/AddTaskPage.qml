import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../Components"
import "../../js/Storage.js" as JS

Page {
	id: addTaskPage
	title: qsTr("Add Task")

	ScrollView {
		anchors.fill: parent
        anchors.margins: 15*dp
		flickableItem.interactive: true
		flickableItem.flickableDirection: Flickable.VerticalFlick

		GridLayout {
			id: mainGrid
			columns: 2
            rowSpacing: 25*dp; columnSpacing: 15*dp

			LineLabel {
				text: qsTr("Task name")
			}
			LineEdit {
				id: nameEdit
				Layout.fillWidth: true
				onTextChanged: {
					if(text === "") { addTaskPage.title = qsTr("Add Task") }
					else { addTaskPage.title = text }
				}
			}

			LineLabel {
				text: qsTr("Project?")
			}
			CheckBox {
				Layout.fillWidth: true
			}

			LineLabel {
				text: qsTr("Importance")
			}
			GroupBox {
				Layout.fillWidth: true
			}

			LineLabel {
				text: qsTr("Deadline")
			}
			LineEdit {
				id: deadlineEdit
				Layout.fillWidth: true
			}

			LineLabel {
				text: qsTr("Detail")
			}
			BoxEdit {
				id: detailEdit
				Layout.fillWidth: true
                Layout.preferredHeight: 150*dp

			}

			LineLabel {
				text: qsTr("Target time")
			}
			LineEdit {
				id: targetTimeEdit
				Layout.fillWidth: true
			}

			LineLabel {
				text: qsTr("Current status") // TODO rename
			}
			Slider {
				Layout.fillWidth: true
			}

			LineLabel {
				text: qsTr("Tags")
			}
			LineEdit {
				Layout.fillWidth: true
			}
		}

		style: ScrollViewStyle {
            minimumHandleLength: 40*dp
			transientScrollBars: true
		}
	}
}
