QT += qml quick quickcontrols2

CONFIG += c++14

SOURCES += main.cpp \
    realtime.cpp \
    f_timer.cpp \
    f_converter.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    realtime.h \
    f_timer.h \
    f_converter.h

DISTFILES +=

