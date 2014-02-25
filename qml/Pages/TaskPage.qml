import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import "../Components"

Page {
    id: taskPage

    property int taskId
    property var task

    onTaskIdChanged: task = storage.readTaskById(taskId)

    ScrollView {
        anchors.fill: parent
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        ColumnLayout {
            id: mainCol
            width: parent.width

            Text {
                id: name
                text: qsTr("text")
            }
            FlatButton {
                text: "test"
            }
        }
    }
}
