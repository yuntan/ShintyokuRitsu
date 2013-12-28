import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Item {
	property bool isProject
	property string name
	property string detail
	property int percent
	property string tag
	property int importance

	width: childrenRect.width
	height: childrenRect.height

	Label {
		text: name + ": " + detail + "(" + percent + "%)"
	}
}
