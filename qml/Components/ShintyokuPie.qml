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
            anchors.centerIn: parent
            text: percent + "%"
            color: "#f9f9f9"
            font.bold: true; font.pixelSize: pie.height / 4
        }
    }

    NumberAnimation on arcEnd {
        duration: 3000
        easing.type: Easing.InOutQuad
        from: 90; to: 90 - percent * 3.6
    }
}
