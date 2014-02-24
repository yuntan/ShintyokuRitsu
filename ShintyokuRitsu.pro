TARGET = ShintyokuRitsu
TEMPLATE = app

QT += qml quick widgets network sql
android : QT += androidextras

QMAKE_CXXFLAGS += -std=c++0x

SOURCES += src/main.cpp

QML_FILES += \
	qml/main.qml \
	qml/Pages/MainListPage.qml \
	qml/Pages/TaskItem.qml \
	qml/Pages/AddTaskPage.qml \
	qml/Components/Page.qml \
	qml/Components/ShintyokuPie.qml \
	qml/Components/LineLabel.qml \
	qml/Components/LineEdit.qml \
	qml/Components/BoxEdit.qml \
	qml/Components/BoxLabel.qml \
	qml/Components/DayPicker.qml \
	qml/Components/TimePicker.qml \
    qml/Components/FlatButton.qml \
    qml/Components/TitleBarButton.qml \
    qml/Components/Card.qml

JS_FILES += \
	js/Storage.js

OTHER_FILES += $$QML_FILES $$JS_FILES \
    android/AndroidManifest.xml

RESOURCES += \
    qml/qml.qrc \
    img/img.qrc \
    js/js.qrc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
