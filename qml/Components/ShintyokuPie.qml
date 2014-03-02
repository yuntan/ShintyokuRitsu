import QtQuick 2.2
import ShintyokuRitsu 1.0

PieChart {
    id: pie
    property int percent: 0

    color: "#c83737"; border.color: color
    fill: true
    arcStart: 90

    PieChart {
        anchors {
            fill: parent
            margins: pie.height / 10
        }
        color: "#ff7f2a"; border.color: color

        LineLabel {
            id: percentLabel
            anchors.centerIn: parent
            text: percent; color: "whitesmoke"
            //                color: "#f9f9f9"
            font.bold: true; font.pixelSize: pie.height * 3 / 8
        }
        LineLabel {
            anchors { top: percentLabel.top; left: percentLabel.right }
            text: "%"; color: "#ffccaa"
            font.bold: true; font.pixelSize: pie.height / 6
        }
    }

    NumberAnimation on arcEnd {
        duration: 3000
        easing.type: Easing.InOutQuad
        from: 90; to: 90 - percent * 3.6
    }
}
