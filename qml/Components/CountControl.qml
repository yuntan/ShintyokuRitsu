import QtQuick 2.2

Column {
    id: control

    property int currentValue
    property int addingValue
    property int minValue: 0
    property int maxValue: 100
    property int stepSize: 1

    Rectangle {
        id: countUpRect
        width: parent.width; height: parent.height / 2
        color: countUpMouse.pressed ? "#40000000" : "transparent"
        Image {
            id: countUpImg
            anchors.centerIn: parent
            width: parent.width; height: width
            source: currentValue + addingValue < maxValue ? "qrc:/img/upArrow.png"
                                                          : "qrc:/img/upArrow2.png"
        }
        MouseArea {
            id: countUpMouse
            anchors.fill: parent
            onClicked: if(currentValue + addingValue < maxValue) { addingValue += stepSize }
            onPressAndHold: countUpTimer.start(); onReleased: countUpTimer.stop()
        }
        Timer {
            id: countUpTimer
            interval: 300; triggeredOnStart: true; repeat: true
            onTriggered: if(currentValue + addingValue < maxValue) { addingValue += stepSize }
        }
    }

    Rectangle {
        id: countDownRect
        width: parent.width; height: parent.height / 2
        color: countDownMouse.pressed ? "#40000000" : "transparent"
        Image {
            id: countDownImg
            anchors.centerIn: parent
            width: parent.width; height: width
            source: currentValue + addingValue > minValue ? "qrc:/img/downArrow.png"
                                                          : "qrc:/img/downArrow2.png"
        }
        MouseArea {
            id: countDownMouse
            anchors.fill: parent
            onClicked: if(currentValue + addingValue > minValue) { addingValue -= stepSize }
            onPressAndHold: countDownTimer.start(); onReleased: countDownTimer.stop()
        }
        Timer {
            id: countDownTimer
            interval: 300; triggeredOnStart: true; repeat: true
            onTriggered: if(currentValue + addingValue > minValue) { addingValue -= stepSize }
        }
    }
}
