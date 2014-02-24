import QtQuick 2.2
import QtQuick.Window 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"

Page {
	id: mainListPage
	title: qsTr("How is the progress?")

	signal addTask()

	ScrollView {
		anchors.fill: parent
		flickableItem.interactive: true
		flickableItem.flickableDirection: Flickable.VerticalFlick

        Column {
            id: mainCol
            spacing: 0
            Repeater {
                model: {
                    console.debug("Making model...")
                    var r = storage.readTasks(0)
                    for(var i = 0; i < r.rows.length; i++) {
                        listModel.append({   "id": r.rows.item(i)['id'],
                                             "name": r.rows.item(i)['name'],
                                             "isProject": r.rows.item(i)['isProject'],
                                             "importance": r.rows.item(i)['importance'],
                                             "deadline": r.rows.item(i)['deadline'],
                                             "detail": r.rows.item(i)['detail'],
                                             "targetTime": r.rows.item(i)['targetTime'],
                                             "percent": r.rows.item(i)['percent'],
                                             "folder": r.rows.item(i)['folder'],
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
                    folder: model.folder
                }
            }
        }

		style: ScrollViewStyle {
            minimumHandleLength: 8*dp
			transientScrollBars: true
		}
	}

	ListModel {id: listModel }

    titleBar: TitleBarButton {
        width: height; height: parent.height
        iconSource: "qrc:/img/plus.png"
        onClicked: addTask()
    }
}
