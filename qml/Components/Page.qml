import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

Rectangle {
	id: page

	// ensure children added do not draw over the titleBar
	property alias data: main.data
	property alias title: titleLabel.text
	property alias titleBar: titleBarItem.data
    property color mainColor: "#ffdd55"
    property color titleColor: "#ff9955"

	//modify statusBar's label
	signal updateStatusBar(string message)
    signal titleIconClicked()
    signal titleLabelClicked()

	color: mainColor

	Rectangle {
		id: titleBarRect

		z:10 // so page contents doesn't draw on top
		anchors.top: parent.top
		width: parent.width
        height: 50*dp

		color: titleColor

		RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                id: titleIconRect
                Layout.minimumWidth: parent.height
                Layout.fillHeight: true
//				enabled: page.Stack.index > 1
                color: Qt.darker(titleColor, 1.2)
                Image {
                    id: titleIcon
                    anchors.fill: parent
                    anchors.margins: 5*dp
                    source: "qrc:/img/app72.png"
                    fillMode: Image.PreserveAspectFit
                }
                // push feedback
                Rectangle {
                    anchors.fill: parent
                    color: titleIconMouse.pressed ? "#40000000" : "transparent"
                }
                MouseArea {
                    id: titleIconMouse
                    anchors.fill: parent

                    onClicked: page.titleIconClicked()
                }
            }

			Rectangle {
				id: titleLabelRect

				Layout.fillWidth: true
				Layout.fillHeight: true
                color: titleLabelMouse.pressed ? "#40000000" : "transparent"
				Label {
					id: titleLabel

                    width: parent.width - 5*dp
					anchors {
						verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 5*dp
					}

					color: "whitesmoke"
                    font.pixelSize: 25*dp
					fontSizeMode: Text.HorizontalFit
					font.bold: true
				}
				MouseArea {
                    id: titleLabelMouse
					anchors.fill: parent
                    onClicked: page.titleLabelClicked()
				}
			}

            Item {
                id: titleBarItem
                Layout.minimumWidth: childrenRect.width
                Layout.preferredWidth: childrenRect.width
                Layout.fillHeight: true
            }

            Item { // spacer
                Layout.minimumWidth: 5*dp
                Layout.preferredWidth: 5*dp
            }
        }
    }

	//bottom border line of titleBar
	Rectangle {
		id: titleBarLine
		anchors.top: titleBarRect.bottom
        width: parent.width; height: 5*dp
		color: Qt.darker(titleColor, 1.6)
	}

	// shadow of titleBar
	Rectangle {
		id:	titleBarShadow

		z:10
		width: parent.width; height: 5
		anchors.top: titleBarLine.bottom

		gradient: Gradient {
			GradientStop {position: 0; color: "#80000000"}
			GradientStop {position: 1; color: "#00000000"}
		}
	}

	// main contents of	the page
	Item {
		id: main

		z: 2
		anchors {
			top: titleBarLine.bottom
			bottom: parent.bottom
			left: parent.left
			right: parent.right
		}
	}
}
