TARGET = ShintyokuRitsu
TEMPLATE = app

QT += qml quick widgets network sql
QMAKE_CXXFLAGS += -std=c++0x

SOURCES += main.cpp

OTHER_FILES += \
	qml/main.qml

RESOURCES += \
	qml.qrc
