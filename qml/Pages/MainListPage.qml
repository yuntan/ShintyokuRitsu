import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"
import "../../js/Utils.js" as Utils

Page {
	id: mainListPage
	title: qsTr("How is the progress?")

	signal addTask()
    signal openTask(int taskId)

	ScrollView {
		anchors.fill: parent

		flickableItem.interactive: true
		flickableItem.flickableDirection: Flickable.VerticalFlick

        ColumnLayout {
            id: mainCol
            width: mainListPage.width

            spacing: 0
            Repeater {
                model: Utils.taskModel(storage.readTasks(), mainListPage)

                delegate: TaskItem {
                    width: mainWindow.width
                    taskId: model.taskId
                    name: model.name
                    isProject: model.isProject
                    importance: model.importance
                    deadline: model.deadline
                    detail: model.detail
                    percent: model.percent
                    folder: model.folder
                    onClicked: openTask(taskId)
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
