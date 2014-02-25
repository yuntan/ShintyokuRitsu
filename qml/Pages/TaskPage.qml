import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"

Page {
    id: taskPage

    property int taskId
    property var task

    signal commit(int taskId)

    onTaskIdChanged: task = storage.readTaskById(taskId)

    title: task['name']
    titleColor: {
        switch(task['importance']) {
        case 0: return "#ffaaaa"
        case 1: return "#ff8080"
        case 2: return "#ff5555"
        case 3: return "#ff2a2a"
        }
    }

    ScrollView {
        anchors {
            fill: parent
            margins: 10*dp
        }

        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        contentItem: ColumnLayout {
            id: mainCol
            width: taskPage.width - 20*dp // referencing parent is not effective
            spacing: 20*dp

            Item {
                id: mainItem
                Layout.fillWidth: true
                Layout.preferredHeight: Math.max(detailLabel.height, width * 0.4 + 10*dp)
                BoxLabel {
                    id: detailLabel
                    anchors {
                        top: parent.top
                        left: parent.left; right: pie.left
                    }
                    text: "%1:\n%2".arg(qsTr("detail")).arg(task['detail'])
                }
                ShintyokuPie {
                    id: pie
                    anchors {
                        top: parent.top; right: parent.right
                        margins: 5*dp
                    }
                    width: parent.width * 0.4; height: width
                    percent: task['percent']
                }
            }

            Item {
                Layout.fillWidth: true; Layout.preferredHeight: 50*dp
                ImportanceRect {
                    anchors {
                        top: parent.top; bottom: parent.bottom
                        left: parent.left; right: folRect.left
                    }
                    width: parent.width / 2
                    importance: task['importance']
                }
                FolderRect {
                    id: folRect
                    anchors {
                        top: parent.top; bottom: parent.bottom
                        right: parent.right
                    }
                    width: parent.width / 2
                    folder: task['folder']
                }
            }

            Item {
                id: deadlineItem
                Layout.fillWidth: true
                Layout.preferredHeight: 0
            }

            Rectangle {
                id: timeLapseItem
                Layout.fillWidth: true; Layout.preferredHeight: 40*dp
                color: "transparent"; border.color: "white"
                Rectangle {
                    anchors {
                        top: parent.top; bottom: parent.bottom
                        left: parent.left
                    }
//                    width: parent.width * task['targetTime'] / passedTime
                    width: parent.width * 0.7
                    color: "#c83737"
                }
                LineLabel {
                    anchors.centerIn: parent
                    color: "whitesmoke"
                    text: "Target time: %1h %2m"
                    .arg(Math.floor(task['targetTime'] / 60))
                    .arg(task['targetTime'] % 60)
                }
            }

            FlatButton {
                Layout.preferredWidth: parent.width - 40*dp
                Layout.preferredHeight: 45*dp
                Layout.alignment: Qt.AlignHCenter
                color: "#66ff2a2a"
                text: qsTr("Commit")
                fontPixelSize: 30*dp
                onClicked: commit(taskId)
            }
        }

        style: ScrollViewStyle {
            minimumHandleLength: 40*dp
            transientScrollBars: true
        }
    }
}
