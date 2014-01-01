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
				console.debug("Making model...")
				var storage = new JS.Storage()
				var r = storage.readTasks()
				for(var i = 0; i < r.rows.length; i++) {
					listModel.append({
										 "id": r.rows.item(i)['id'],
										 "name": r.rows.item(i)['name'],
										 "isProject": r.rows.item(i)['isProject'],
										 "importance": r.rows.item(i)['importance'],
										 "deadline": r.rows.item(i)['deadline'],
										 "detail": r.rows.item(i)['detail'],
										 "targetTime": r.rows.item(i)['targetTime'],
										 "percent": r.rows.item(i)['percent'],
										 "tag": r.rows.item(i)['tag'],
										 "projectId": r.rows.item(i)['projectId']})
				}
				return listModel
			}

			delegate: TaskItem {
				name: model.name
				isProject: model.isProject
				importance: model.importance
				deadline: model.deadline
				detail: model.detail
				percent: model.percent
				tag: model.tag
			}
		}

		style: ScrollViewStyle {
			minimumHandleLength: 8*mm
			transientScrollBars: true
		}
	}

	ListModel {id: listModel }
}
