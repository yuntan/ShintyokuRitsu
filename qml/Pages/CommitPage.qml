import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../Components"

Page {
    id: commitPage

    property int taskId
    property var task

    signal commited()

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
            width: commitPage.width - 40*dp
            spacing: 30*dp

            // spacer
            Item { Layout.fillWidth: true; Layout.preferredHeight: 0 }

            LineLabel {
                text: new Date().toLocaleDateString()
                font.pointSize: 18; font.bold: true
            }

            RateCounter {
                id: rateCounter
                Layout.fillWidth: true; Layout.preferredHeight: height
                currentRate: task['percent']
            }

            TimeCounter {
                id: timeCounter
                Layout.fillWidth: true; Layout.preferredHeight: height
            }

            ShintyokuBar {
                id: timeLapseBar
                Layout.fillWidth: true; Layout.preferredHeight: 40*dp
                color: "crimson"
//                percent: (task['passedTime'] + timeCounter.timeLapse) / task['targetTime']
                LineLabel {
                    anchors.centerIn: parent
                    color: "darkorange"; font.bold: true; font.pixelSize: 15
                    text: "%1h %2m / %3h %4m"
                    .arg(Math.floor(task['passedTime'] / 60))
                    .arg(task['passedTime'] % 60)
                    .arg(Math.floor(task['targetTime'] / 60))
                    .arg(task['targetTime'] % 60)
                }
            }

            Column {
                Layout.fillWidth: true; Layout.preferredHeight: childrenRect.height

                LineLabel { text: "Comment:" }
                BoxEdit {
                    id: commentEdit
                    width: parent.width; height: 150*dp
                }
            }

            FlatButton {
                Layout.preferredWidth: parent.width - 40*dp
                Layout.preferredHeight: 45*dp
                Layout.alignment: Qt.AlignHCenter
                color: "#66ff2a2a"
                text: qsTr("Commit")
                fontPixelSize: 30*dp
            }

            // spacer
            Item { Layout.fillWidth: true; Layout.preferredHeight: 50*dp }
        }

        style: ScrollViewStyle {
            minimumHandleLength: 40*dp
            transientScrollBars: true
        }
    }
}


