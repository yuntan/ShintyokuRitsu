import QtQuick 2.2
import QtQuick.Layouts 1.1
import "../Components"

Item {
    id: timeCounter

    property int timeLapse: hour * 60 + minute
    property alias hour: hourControl.addingValue
    property alias minute: minuteControl.addingValue

    onMinuteChanged: { if(minute === 60) { hour++; minute = 0 } }

    height: label.height + counter.anchors.margins + counter.height

    Row {
        id: counter
        anchors {
            top: parent.top; horizontalCenter: parent.horizontalCenter
            margins: 10*dp
        }
        height: 80*dp; spacing: 15*dp

        RowLayout {
            width: childrenRect.width; height: parent.height
            LineLabel {
                id: hourLabel
                text: hour
                font.pointSize: 54
            }
            LineLabel {
                text: "h"; color: "#ff9955"
                font.pointSize: 30; font.bold: true
                Layout.alignment: Qt.AlignBottom
            }
        }

        CountControl {
            id: hourControl
            width: 30*dp; height: parent.height
            currentValue: 0; addingValue: hour
            minValue: 0; maxValue: 60; stepSize: 1
        }

        RowLayout {
            height: parent.height
            LineLabel {
                id: minuteLabel
                text: minute
                font.pointSize: 54
            }
            LineLabel {
                text: "m"; color: "#ff9955"
                font.pointSize: 30; font.bold: true
                Layout.alignment: Qt.AlignBottom
            }
        }

        CountControl {
            id: minuteControl
            width: 30*dp; height: parent.height
            currentValue: 0; addingValue: minute
            minValue: 0; maxValue: 60; stepSize: 10
        }
    }
}
