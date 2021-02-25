#ifndef LIVEIMAGEPROVIDER_H
#define LIVEIMAGEPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>
#include <QtDebug>
#include<QFileInfo>
#include<QtMultimedia>

#include "dataprovider.h"

#include<fileref.h>
#include<tag.h>
#include <mpeg/mpegfile.h>
#include <attachedpictureframe.h>
#include <mpeg/id3v2/id3v2tag.h>
#include <mp4/mp4file.h>
#include <mp4/mp4tag.h>
#include <mp4/mp4coverart.h>


class LiveImageProvider : public QObject , public QQuickImageProvider
{
    Q_OBJECT
public:
    explicit LiveImageProvider(QObject *parent = nullptr);
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

public slots:
    void updateImage(QImage image);
    static void trytosolve(){qDebug()<<"injaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam";};

signals:
    void imageChanged();



private:
    QImage image;
    QImage default_image;
    QMediaPlayer music;

};

#endif // LIVEIMAGEPROVIDER_H
