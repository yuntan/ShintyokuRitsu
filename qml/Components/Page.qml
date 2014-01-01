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
	property color mainColor: "#56c4c3"
	property color titleColor: "#1ebba6"

	//modify statusBar's label
	signal updateStatusBar(string message)
	//back 1 page
	signal back()
	//open menu
	function showMenu() { }

	color: mainColor

	Rectangle {
		id: titleBarRect

		z:10 // so page contents doesn't draw on top
		anchors.top: parent.top
		width: parent.width
		height: 10*mm

		color: titleColor

		RowLayout {
			anchors.fill: parent
			spacing: 2.*mm

			// Back arrow button
			Rectangle {
				id: backButton
				Layout.preferredWidth: 10*mm
				Layout.fillHeight: true
				enabled: page.Stack.index > 0
				color: Qt.darker(titleColor, 1.2)
				Image {
					anchors.fill: parent
					anchors.margins: 1*mm
					source: "qrc:/img/aztter64.png"
					fillMode: Image.PreserveAspectFit
				}
				// push feedback
				Rectangle {
					anchors.fill: parent
					color: mouseBack.pressed ? "#40000000" : "transparent"
				}
				MouseArea {
					id: mouseBack
					anchors.fill: parent

					onClicked: page.back()
				}
			}

			Rectangle {
				id: titleLabelRect

				Layout.fillWidth: true
				Layout.fillHeight: true
				color: mouseMenu.pressed ? "#40000000" : "transparent"
				Label {
					id: titleLabel

					width: parent.width
					anchors {
						verticalCenter: parent.verticalCenter
						left: parent.left
					}

					color: "whitesmoke"
					font.pointSize: 21
					fontSizeMode: Text.HorizontalFit
					font.bold: true
				}
				MouseArea {
					id: mouseMenu
					anchors.fill: parent
					onClicked: page.showMenu()
				}
			}

			Item {
				Layout.minimumWidth: titleBarItem.childrenRect.width + 2.*mm
				Layout.fillHeight: true
				ToolBar {
					id: titleBarItem
					anchors {
						fill: parent
						topMargin: 1.*mm
						bottomMargin: 1.*mm
						rightMargin: 2.*mm
					}
					style: ToolBarStyle {
						background: Rectangle {
							width: control.width; height: control.height
							color: "transparent"
						}
					}
				}
			}
		}
	}

	//bottom border line of titleBar
	Rectangle {
		id: titleBarLine
		anchors.top: titleBarRect.bottom
		width: parent.width; height: 1*mm
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

	Image {
		id: backgroundImage

		z: 0
		anchors {
			top: titleBarLine.bottom
			bottom: parent.bottom
			left: parent.left
			right: parent.right
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
