#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<songitemmodeler.h>
#include <backend2.h>
#include <QQmlContext>
#include<QCoreApplication>
#include<iostream>
#include "tools.h"
#include<QFontDatabase>
#include <QQuickStyle>
#include <QDebug>
#include <QScopedPointer>
#include "liveimageprovider.h"
#include"dataprovider.h"




#include<fileref.h>
#include<tag.h>
#include <mpeg/mpegfile.h>
#include <attachedpictureframe.h>
#include <mpeg/id3v2/id3v2tag.h>
#include <mp4/mp4file.h>
#include <mp4/mp4tag.h>
#include <mp4/mp4coverart.h>







//#include <QtAndroidExtras>
//#include <QtAndroid>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//    auto result = QtAndroid::checkPermission(QString("android.permission.READ_EXTERNAL_STORAGE"));
//    if (result == QtAndroid::PermissionResult::Denied){
//    qDebug()<<"dont have permission";
//    QtAndroid::PermissionResultMap resulthash = QtAndroid::requestPermissionsSync(QStringList({"android.permission.READ_EXTERNAL_STORAGE"}));
//    if(resulthash["android.permission.READ_EXTERNAL_STORAGE"] == QtAndroid::PermissionResult::Denied){
//        return 0;
//    }
//    }
//    else{
//        qDebug()<<"have this permission";
//    }
    tools tools;
    qmlRegisterType<songitemmodeler>("SongFinder",1,0,"Songfinder");


    QQuickStyle::setStyle("Material");
//    qmlRegisterType<backend2>("Bend",1,0,"BackEndFinder");
    QGuiApplication app(argc, argv);

    DataProvider* dp = new DataProvider(&app);
    app.setWindowIcon(QIcon("qrc:/new/prefix1/thumbnail.svg"));

//    backend2 bend;
//    QScopedPointer<LiveImageProvider> liveimage(new LiveImageProvider());
    LiveImageProvider liveimage;

    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty("imageProvider",&liveimage);
    engine.addImageProvider("imageprovider", &liveimage);
//    engine.rootContext()->setContextProperty("backend",&bend);
    engine.rootContext()->setContextProperty("tools",&tools);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
