#include "liveimageprovider.h"


LiveImageProvider::LiveImageProvider(QObject *parent) : QObject(parent),QQuickImageProvider(QQuickImageProvider::Image)
{

    this->default_image = QImage(":/new/prefix1/thumbnail.svg");
    this->blockSignals(false);

    connect(&music,&QMediaPlayer::mediaStatusChanged,this,[this](){
        qDebug()<<"from image provider signal"<<music.mediaStatus()<<music.metaData("CoverArtUrlSmall").Image<<music.duration();
        //        qDebug()<<music.duration()<<"is cover art with id";
        updateImage(music.metaData("CoverArtImage").value<QImage>());
        //        emit imageChanged();

    });

}

QImage LiveImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug()<<"hehehehhehehehehehehheheheh2";

    QFileInfo info(id.split("=")[1]);
    music.setMedia(QUrl::fromLocalFile(info.path()+"/"+info.fileName()));
    qDebug()<<"info is "<<id.split("=")[1]<<info.path()<<info.fileName();
    qDebug()<<"/home/sub/Downloads/Haj Mahmood Karimi - Moharram 98 (4) (5) (320).mp3";
    //    music.setMedia(QUrl(id.split("=")[1]));
    QImage result = image;
    if (result.isNull()){
        result = this->default_image;
    }
    if(size) {
        *size = result.size();
    }
    if(requestedSize.width() > 0 && requestedSize.height() > 0) {
        result = result.scaled(requestedSize.width(), requestedSize.height(), Qt::KeepAspectRatio);
        //        qDebug()<<"hehehehhehehehehehehheheheh";
    }
    return  result;
}

void LiveImageProvider::updateImage(QImage image)
{
    if(this->image != image){
        qDebug()<<"che gandi zadi dobare bejesh";
        this->image = image;
        //        emit imageChanged();
    }
}
