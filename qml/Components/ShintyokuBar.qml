import QtQuick 2.2

Rectangle {
    id: timeLapseItem

    property int percent: 50
    property alias color: rect.color

    color: "transparent"; border.color: "white"
    Rectangle {
        id: rect
        anchors {
            top: parent.top; bottom: parent.bottom
            left: parent.left
        }
        width: parent.width * (percent < 0 ? 0 : percent > 100 ? 100 : percent) / 100
    }
}
