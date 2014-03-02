import QtQuick 2.2
import "../Components"

Item {
    id: rateCounter

    property int currentRate: 0
    property alias addingRate: control.addingValue

    height: 115*dp + flucturationLabel.height

    Item {
        id: counter
        anchors {
            top: parent.top; horizontalCenter: parent.horizontalCenter
            margins: 10*dp
        }
        width: 240*dp; height: 80*dp

        Image {
            id: plusMinusImg
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            width: 50*dp; height: 50*dp
            source: addingRate > 0 ? "qrc:/img/plus.png"
                                   : addingRate < 0 ? "qrc:/img/minus.png" : ""
        }

        LineLabel {
            id: countLabel
            anchors {
                right: percentLabel.left; rightMargin: 10*dp
                verticalCenter: parent.verticalCenter
            }
            text: Math.abs(addingRate)
            font.pointSize: 60
        }

        LineLabel {
            id: percentLabel
            anchors {
                top: parent.top; right: control.left
                rightMargin: 20*dp
            }
            text: "%"
            font.pointSize: 18
        }

        CountControl {
            id: control
            anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
            width: 30*dp
            currentValue: currentRate; addingValue: addingRate
            minValue: 0; maxValue: 100; stepSize: 5
        }
    }

    LineLabel {
        id: flucturationLabel
        anchors {
            top: counter.bottom; margins: 15*dp
            horizontalCenter: parent.horizontalCenter
        }
        height: implicitHeight

        text: "%0\% → %1\%".arg(currentRate).arg(currentRate + addingRate)
        font.pointSize: 24
    }
}

