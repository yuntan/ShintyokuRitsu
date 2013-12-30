import QtQuick 2.2
import QtQuick.Window 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"
import "../../js/Storage.js" as JS

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
//			model: MainListModel { }
//			model: {
//			var storage = new JS.Storage()
//				return storage.taskListModel()
//			}

			model: {
				var storage = new JS.Storage()
				var r = storage.readTasks("")
				for(var i = 0; i < r.rows.length; i++) {
					listModel.append({"name": r.rows.item(i)['name'],
									 "detail": r.rows.item(i)['detail'],
									 "percent": r.rows.item(i)['percent']})
				}
				return listModel
			}

			delegate: TaskItem {
				isProject: false
				name: model.name
				detail: model.detail
				percent: model.percent
			}
		}

		style: ScrollViewStyle {
			minimumHandleLength: 8*mm
			transientScrollBars: true
		}
	}

	ListModel {id: listModel }
}
