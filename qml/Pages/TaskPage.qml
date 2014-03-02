import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"

Page {
    id: taskPage

    property int taskId
    property var task

    signal openCommitPage(int taskId)

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
        anchors { fill: parent; leftMargin: 20*dp }
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        contentItem: ColumnLayout {
            id: mainCol
            width: taskPage.width - 40*dp // referencing parent is not effective
            spacing: 30*dp

            // spacer
            Item { Layout.fillWidth: true; Layout.preferredHeight: 0 }

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

            ColumnLayout {
                id: timeCountItem
                Layout.fillWidth: true
                LineLabel {
                    id: label
                    text: "Passage of time:"
                    font.pointSize: 15
                }
                ShintyokuBar {
                    id: timeLapseBar
                    Layout.fillWidth: true; Layout.preferredHeight: 40*dp
                    color: "crimson"
//                    percent: task['passedTime'] / task['targetTime']
                    LineLabel {
                        anchors.centerIn: parent
                        color: "darkorange"; font.bold: true; font.pointSize: 15
                        text: "%1h %2m / %3h %4m"
                        .arg(Math.floor(task['passedTime'] / 60))
                        .arg(task['passedTime'] % 60)
                        .arg(Math.floor(task['targetTime'] / 60))
                        .arg(task['targetTime'] % 60)
                    }
                }
            }

            FlatButton {
                Layout.preferredWidth: parent.width - 40*dp
                Layout.preferredHeight: 45*dp
                Layout.alignment: Qt.AlignHCenter
                color: "#66ff2a2a"
                text: qsTr("Commit")
                fontPixelSize: 30*dp
                onClicked: openCommitPage(taskId)
            }
        }

        style: ScrollViewStyle {
            minimumHandleLength: 40*dp
            transientScrollBars: true
        }
    }
}
