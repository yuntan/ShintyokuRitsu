TARGET = ShintyokuRitsu
TEMPLATE = app

QT += qml quick widgets network sql
QMAKE_CXXFLAGS += -std=c++0x

SOURCES += main.cpp

OTHER_FILES += \
	qml/main.qml \
	qml/Pages/MainListPage.qml \
	qml/Pages/TaskItem.qml \
	qml/Components/Page.qml \
	js/Storage.js \
    qml/Components/ShintyokuPie.qml \
    qml/Pages/AddTaskPage.qml \
    qml/Components/LineLabel.qml \
    qml/Components/LineEdit.qml \
    qml/Components/BoxEdit.qml \
    qml/Components/BoxLabel.qml \
    qml/Components/DayPicker.qml \
    qml/Components/TimePicker.qml

RESOURCES += \
	qml.qrc
