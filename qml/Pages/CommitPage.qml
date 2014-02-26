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
        anchors {
            fill: parent
            margins: 10*dp
        }

        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        contentItem: ColumnLayout {
            LineLabel {
                text: Date().toLocaleDateString()
                font.pointSize: 15
            }

//            RateCounter {
//                Layout.preferredHeight: 50*dp
//            }
        }

        style: ScrollViewStyle {
            minimumHandleLength: 40*dp
            transientScrollBars: true
        }
    }
}


