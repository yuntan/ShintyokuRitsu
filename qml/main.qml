import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "Pages"
import "../js/Storage.js" as JS

ApplicationWindow {
	id: mainWindow
	title: qsTr("ShintyokuRitsu")

    width: 360*dp; height: 640*dp
    minimumWidth: 360*dp; minimumHeight: 200*dp

    Component.onCompleted: {
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
//        onTitleIconClicked: openSideMenu()
		onAddTask: stackView.push(addTaskPage)
        onUpdateStatusBar: mainWindow.updateStatusBar(message)
        onOpenTask: {
            openingId = taskId // cannot access taskPage.taskId.
            stackView.push(taskPage)
        }
	}
	property Component addTaskPage: AddTaskPage {
        onTitleIconClicked: stackView.pop()
        onUpdateStatusBar: mainWindow.updateStatusBar(message)
	}
    property Component taskPage: TaskPage {
        taskId: openingId // cannot access taskPage.taskId. workaround
        onTitleIconClicked: stackView.pop()
        onUpdateStatusBar: mainWindow.updateStatusBar(message)
    }

    property var storage: new JS.Storage()
    property int openingId

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
				PropertyAnimation {
					target: enterItem
					property: "x"
					duration: 500
					easing.type: Easing.OutQuad
					from: enterItem.width
					to: 0
				}
			}

			popTransition: StackViewTransition {
				PropertyAnimation {
					target: exitItem
					property: "x"
					duration: 500
					easing.type: Easing.InQuad
					from: 0
					to: enterItem.width
				}
			}

			replaceTransition: StackViewTransition {
				PropertyAnimation {
					target: enterItem
					property: "x"
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
        height: statusLabel.text !== "" ? 25*dp : 0

		Behavior on height {
			NumberAnimation {
				easing.type: Easing.OutSine
			}
		}

		style: StatusBarStyle {
			background: Rectangle {
                implicitHeight: 25*dp
				implicitWidth: mainWindow.width
				color: "#2d373f"
				Rectangle {
					width: parent.width
                    height: 2*dp
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
            font.pixelSize: 20*dp
			font.bold: true
			color: "whitesmoke"
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Timer {
			id: statusBarTimer
            interval: 5000
			running: false
			triggeredOnStart: false
			onTriggered: statusLabel.text = ""
		}
	}
}
