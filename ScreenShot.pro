QT += quick
QT += gui
QT += widgets printsupport

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


HEADERS += \
    area_record.h \
    capture.h \
    copypaintitem.h \
    elementgroup.h \
    freecapture.h \
    gif.h \
    imageprovider.h \
    mylabel.h \
    painteditem.h \
    reccapture.h \
    recorddialog.h \
    share.h

SOURCES += \
    area_record.cpp \
    capture.cpp \
    copypaintitem.cpp \
    freecapture.cpp \
    main.cpp \
    mylabel.cpp \
    painteditem.cpp \
    reccapture.cpp \
    recorddialog.cpp \
    share.cpp

RESOURCES += qml.qrc

INCLUDEPATH += ../../ffmpeg/include/
INCLUDEPATH += $$PWD/src/

LIBS += -L/usr/lib -lavcodec \
        -lavdevice \
        -lavfilter \
        -lavformat \
        -lavutil \
        -lpostproc \

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

FORMS += \
    recorddialog.ui
