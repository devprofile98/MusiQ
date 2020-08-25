QT += quick multimedia quickcontrols2
#androidextras

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += TAGLIB_STATIC
# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        backend.cpp \
        dataprovider.cpp \
        liveimageprovider.cpp \
        main.cpp \
        mostplayedlist.cpp \
        simpleqabstractlist.cpp \
        songitemmodeler.cpp \
        tools.cpp

RESOURCES += qml.qrc \
    files.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    backend.h \
    backend2.h \
    dataprovider.h \
    liveimageprovider.h \
    mostplayedlist.h \
    simpleqabstractlist.h \
    songitemmodeler.h \
    tools.h

DISTFILES += \
#    ../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Brands-Regular-400.otf \
#    ../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Brands-Regular-400.otf \
#    ../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Free-Regular-400.otf \
#    ../Documents/fontawesome/fontawesome-free-5.11.2-desktop/otfs/Font Awesome 5 Free-Solid-900.otf \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}



PRO_PATH=$$PWD
#message($${PRO_PATH}/Dependencies/TagLib/include/)

INCLUDEPATH+= $${PRO_PATH}/Dependencies/TagLib/include/ $${PRO_PATH}/Dependencies/zlib/include/ $${PRO_PATH}/Dependencies/TagLib/include/mpeg/id3v1 $${PRO_PATH}/Dependencies/TagLib/include/mpeg/id3v2



unix{


LIBS+=-L/usr/local/lib -ltag -lz
message("builiding for unix world")

    debug{
        message("from debug point in unix world")
    }

}
win32{

LIBS+=-L$${PRO_PATH}/Dependencies/zlib/lib/ -lzlibd
#LIBS+=-L$${PRO_PATH}/Dependencies/TagLib/lib/ -ltag
LIBS+=-L$${PRO_PATH}/Dependencies/TagLib/lib/ -ltagd
#LIBS+=-L$${PRO_PATH}/Dependencies/zlib/lib/ -lzlib


}















