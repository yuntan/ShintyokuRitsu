import QtQuick 2.2
import QtQuick.Window 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"

Page {
	id: mainListPage
	title: qsTr("Task List")

	ScrollView {
		anchors.fill: parent
		flickableItem.interactive: true
		flickableItem.flickableDirection: Flickable.VerticalFlick

		ListView {
			id: mainList

			property real mm: Screen.pixelDensity

			clip: true
//			model: mainListModel
			model: ListModel {
				ListElement {
					_name: "進捗1"
					_detail: "hogehoge"
					_percent: "80"
				}
				ListElement {
					_name: "進捗2"
					_detail: "fugafuga"
					_percent: "60"
				}
				ListElement {
					_name: "進捗3"
					_detail: "hogefuga"
					_percent: "40"
				}
				ListElement {
					_name: "進捗4"
					_detail: "piyopiyo"
					_percent: "20"
				}
				ListElement {
					_name: "進捗5"
					_detail: "poyopoyo"
					_percent: "0"
				}
			}

			delegate: TaskItem {
				isProject: false
				name: _name
				detail: _detail
				percent: _percent
			}
		}

		style: ScrollViewStyle {
			minimumHandleLength: 8*mm
			transientScrollBars: true
		}
	}

	MainListModel {
		id: mainListModel
	}
}
