QT += quick multimedia quickcontrols2
#androidextras

CONFIG += c++17


DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += TAGLIB_STATIC
TARGET = "MusiQ"
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

INCLUDEPATH+= $${PRO_PATH}/Dependencies/TagLib/include/ $${PRO_PATH}/Dependencies/zlib/include/ $${PRO_PATH}/Dependencies/TagLib/include/mpeg/id3v1 $${PRO_PATH}/Dependencies/TagLib/include/mpeg/id3v2


linux{
LIBS+=-L/usr/local/lib -ltag -lz
message("builiding for linux")

}


windows{

#    LIBS+=-L$${PRO_PATH}/Dependencies/TagLib/lib/ -ltag
#    LIBS+=-L$${PRO_PATH}/Dependencies/zlib/lib/ -lzlib
    debug
    {
        LIBS+=-L$${PRO_PATH}/Dependencies/zlib/lib/ -lzlibd
        LIBS+=-L$${PRO_PATH}/Dependencies/TagLib/lib/ -ltagd
    }


message("builiding for windows")
}
















