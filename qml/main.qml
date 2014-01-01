import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "Pages"

ApplicationWindow {
	id: mainWindow
	title: qsTr("ShintyokuRitsu")

	width: 360
	height: 640

	property real mm: Screen.pixelDensity

	Component.onCompleted : {
		console.log("name: ", Screen.name)
		console.debug("width: ", Screen.width, " height: ", Screen.height)
		if(Screen.primaryOrientation==Qt.LandscapeOrientation) {
			console.debug("LandScape")
		}
		else {
			console.debug("Portrait")
		}
		console.debug("pixelDensity: ", Screen.pixelDensity)
	}

	property Component mainListPage: MainListPage {
		onAddTask: stackView.push(addTaskPage)
	}
	property Component addTaskPage: AddTaskPage {
		onBack: stackView.pop()
	}

	function updateStatusBar (message) {
		statusLabel.text = message
		statusBarTimer.start()
	}

	StackView {
		id: stackView

		anchors.fill: parent
		initialItem: mainListPage

		delegate: StackViewDelegate {
			pushTransition: StackViewTransition {
				XAnimator {
					target: enterItem
					duration: 500
					easing.type: Easing.OutQuad
					from: enterItem.width
					to: 0
				}
			}

			popTransition: StackViewTransition {
				XAnimator {
					target: exitItem
					duration: 500
					easing.type: Easing.InQuad
					from: 0
					to: enterItem.width
				}
			}

			replaceTransition: StackViewTransition {
				XAnimator {
					target: enterItem
					duration: 500
					easing.type: Easing.OutQuad
					from: enterItem.width
					to: 0
				}
				PropertyAnimation {
					target: exitItem
					property: "x"
					duration: 500
					easing.type: Easing.InQuad
					from: 0
					to: enterItem.width
				}
			}
		}
	}

	statusBar: StatusBar {
		width: parent.width
		height: statusLabel.text !== "" ? 5*mm : 0

		Behavior on height {
			NumberAnimation {
				easing.type: Easing.OutSine
			}
		}

		style: StatusBarStyle {
			background: Rectangle {
				implicitHeight: 6*mm
				implicitWidth: mainWindow.width
				color: "#2d373f"
				Rectangle {
					width: parent.width
					height: 2
					color: Qt.darker(parent.color, 1.5)
				}
			}
		}

		Label {
			id: statusLabel
			width: parent.width
			text: ""
			textFormat: Text.RichText
			onLinkActivated: Qt.openUrlExternally(link)
			wrapMode: Text.Wrap
			font.pointSize: 12
			font.bold: true
			color: "whitesmoke"
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Timer {
			id: statusBarTimer
			interval: 10000
			running: false
			triggeredOnStart: false
			onTriggered: statusLabel.text = ""
		}
	}
}
