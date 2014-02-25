import QtQuick 2.2

Rectangle {
    property alias iconSource: image.source
    signal clicked()

    color: mouse.pressed ? "#40000000" : "transparent"

    Image {
        id: image
        width: parent.width * 0.6; height: parent.height * 0.6
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
