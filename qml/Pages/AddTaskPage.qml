import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../Components"

Page {
    id: addTaskPage
    title: qsTr("Add Task")

    ScrollView {
        anchors.fill: parent
        anchors.margins: 15*dp
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        Column {
            spacing: 25*dp

            GridLayout {
                id: mainGrid
                width: addTaskPage.width - 30*dp
                columns: 2
                rowSpacing: 25*dp; columnSpacing: 15*dp

                // row1
                LineLabel {
                    text: qsTr("Task name")
                }
                LineEdit {
                    id: nameEdit
                    Layout.fillWidth: true
                    onTextChanged: {
                        if(text === "") { addTaskPage.title = qsTr("Add Task") }
                        else { addTaskPage.title = text }
                    }
                }

                // row2
                LineLabel {
                    text: qsTr("Project?")
                }
                CheckBox {
                    id: projCheck
                    Layout.fillWidth: true
                }

                // row3
                LineLabel {
                    text: qsTr("Importance")
                }
                GroupBox {
                    Layout.fillWidth: true
                    title: "   " // when title is empty string, checkboxes out of place
                    Column {
                        anchors.fill: parent
                        height: childrenRect.height
                        CheckBox {
                            id: impLowCheck
                            text: "Low"
                            exclusiveGroup: importanceGroup
                        }
                        CheckBox {
                            id: impMedCheck
                            text: "Medium"
                            exclusiveGroup: importanceGroup
                            checked: true
                        }
                        CheckBox {
                            id: impHighCheck
                            text: "High"
                            exclusiveGroup: importanceGroup
                        }
                        CheckBox {
                            id: impVHighCheck
                            text: "Very high"
                            exclusiveGroup: importanceGroup
                        }
                    }
                    ExclusiveGroup { id: importanceGroup }
                }

                // row4
                LineLabel {
                    text: qsTr("Deadline")
                }
                LineEdit {
                    id: deadlineEdit
                    Layout.fillWidth: true
                }

                // row5
                LineLabel {
                    text: qsTr("Detail")
                }
                BoxEdit {
                    id: detailEdit
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150*dp
                }

                // row6
                LineLabel {
                    text: qsTr("Target time")
                }
                LineEdit {
                    id: targetTimeEdit
                    Layout.fillWidth: true
                }

                // row7
                LineLabel {
                    text: qsTr("Current rate")
                }
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 19*dp
                    Slider {
                        id: rateSlider
                        width: parent.width * 0.8; height: parent.height
                        anchors.left: parent.left
                        minimumValue: 0; maximumValue: 100
                        stepSize: 10; tickmarksEnabled: true
                        updateValueWhileDragging: true
                    }
                    LineLabel {
                        anchors.right: parent.right
                        text: rateSlider.value + "%"
                    }
                }

                // row8
                LineLabel {
                    text: qsTr("Folder")
                }
                LineEdit {
                    id: folderEdit
                    Layout.fillWidth: true
                }
            }

            FlatButton {
                width: parent.width - 10*dp; height: 45*dp
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add task")
                fontPixelSize: 30*dp
                onClicked: {
                    if(nameEdit.text === "") {
                        updateStatusBar(qsTr("Name is required"))
                        return
                    }
                    if(targetTimeEdit.text === "") {
                        updateStatusBar(qsTr("Target Time is required"))
                        return
                    }

                    var importance = impLowCheck.checked ? 0 : impMedCheck.checked ? 1 : impHighCheck.checked ? 2 : 3
                    storage.addTask(nameEdit.text, projCheck.checked, importance,
                                    deadlineEdit.text, detailEdit.text, targetTimeEdit.text,
                                    rateSlider.value, folderEdit.text, -1)
                    updateStatusBar(qsTr("Task added"))
                    stackView.pop()
                }
            }
        }

        style: ScrollViewStyle {
            minimumHandleLength: 40*dp
            transientScrollBars: true
        }
    }
}
