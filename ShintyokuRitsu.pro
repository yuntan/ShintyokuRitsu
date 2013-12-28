TARGET = ShintyokuRitsu
TEMPLATE = app

QT += qml quick widgets network sql
QMAKE_CXXFLAGS += -std=c++0x

SOURCES += main.cpp

OTHER_FILES += \
	qml/main.qml \
    qml/Pages/MainListPage.qml \
    qml/Components/Page.qml \
    qml/Pages/MainListModel.qml \
    qml/Pages/TaskItem.qml

RESOURCES += \
	qml.qrc
