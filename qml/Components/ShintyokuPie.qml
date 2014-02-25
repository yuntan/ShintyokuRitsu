import QtQuick 2.2
import ShintyokuRitsu 1.0

PieChart {
    property int percent: 0

    color: "#c83737"; border.color: color
    fill: true
    arcStart: 90

    PieChart {
        anchors {
            fill: parent
            margins: 10*dp
        }
        color: "#ff7f2a"; border.color: color

        LineLabel {
            anchors.centerIn: parent
            text: percent + "%"
            color: "#f9f9f9"
            font.bold: true
        }
    }

    NumberAnimation on arcEnd {
        duration: 3000
        easing.type: Easing.InOutQuad
        from: 90; to: 90 - percent * 3.6
    }
}
