#include "liveimageprovider.h"

LiveImageProvider::LiveImageProvider(QObject *parent) : QObject(parent),QQuickImageProvider(QQuickImageProvider::Image)
{

    this->default_image = QImage("/home/sub/Downloads/twitter.png");
    this->blockSignals(false);

    connect(&music,&QMediaPlayer::mediaStatusChanged,this,[this](){
        qDebug()<<"from image provider signal";
        qDebug()<<music.duration()<<"is cover art with id";
        emit imageChanged();

    });

}

QImage LiveImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QFileInfo info(id.split("=")[1]);
    qDebug()<<"info is "<<info.size();
    music.setMedia(QUrl(id.split("=")[1]));
    music.play();
    QImage result;
    if (result.isNull()){
        result = this->default_image;
    }
    if(size) {
          *size = result.size();
      }
    if(requestedSize.width() > 0 && requestedSize.height() > 0) {
          result = result.scaled(requestedSize.width(), requestedSize.height(), Qt::KeepAspectRatio);
      }
    return  result;
}

void LiveImageProvider::updateImage(const QImage &image)
{
    qDebug()<<"che gandi zadi dobare bejesh";
    if(this->image != image){
        this->image = image;
        emit imageChanged();
    }
}
