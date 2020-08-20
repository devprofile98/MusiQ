#include "liveimageprovider.h"


LiveImageProvider::LiveImageProvider(QObject *parent) : QObject(parent),QQuickImageProvider(QQuickImageProvider::Image)
{

    this->default_image = QImage(":/new/prefix1/thumbnail.svg");
    this->blockSignals(false);

//    connect(&music,&QMediaPlayer::mediaStatusChanged,this,[this](){
//        qDebug()<<"from image provider signal"<<music.mediaStatus()<<music.metaData("CoverArtUrlSmall").Image<<music.duration();
//        //        qDebug()<<music.duration()<<"is cover art with id";
//        updateImage(music.metaData("CoverArtImage").value<QImage>());
//        //        emit imageChanged();

//    });

}

QImage LiveImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{


    qInfo()<<"THE WIDTH OF REQUESTED IMAGE IS "<<size->width() <<" "<<requestedSize.width();
    qInfo()<<"THE HEIGHT OF REQUESTED IMAGE IS "<<size->height() <<" "<<requestedSize.height();

    if (id.toInt() >= DataProvider::all_path->size() || id.toInt() < 0){
        return QImage();
    }
    QImage image;
//    QByteArray bArray;
//    QBuffer buffer(&bArray);

    TagLib::String fileName = "C:\\Users\\sub\\Downloads\\Mohsen Chavoshi - Sharhe Alef.mp3";
    TagLib::String fileType = fileName.substr(fileName.size() - 3).upper();

    qDebug()<<fileType.toCString();
    ImageFile imageFile("C:\\Users\\sub\\Pictures\\work\\well.png");
    if (fileType == "MP3")
    {
        qDebug()<<"from taglib name of the song is utf8"<<DataProvider::all_path[0][id.toInt()];
        TagLib::MPEG::File audioFile( DataProvider::all_path[0][id.toInt()].toUtf8().toStdString().c_str());

        TagLib::ID3v2::Tag* tag = audioFile.ID3v2Tag(true);
//        TagLib::ID3v2::AttachedPictureFrame* frame = new TagLib::ID3v2::AttachedPictureFrame;
        TagLib::ID3v2::FrameList l = tag->frameList("APIC");
        if(l.isEmpty())
                return QImage();

        TagLib::ID3v2::AttachedPictureFrame *f =
                static_cast<TagLib::ID3v2::AttachedPictureFrame *>(l.front());

            image.loadFromData((const uchar *) f->picture().data(), f->picture().size());

            qDebug()<<"111IMAGE SIZE IS "<<image.sizeInBytes();
            image.scaled( requestedSize.width(), requestedSize.height(),Qt::KeepAspectRatio);
            qDebug()<<"IMAGE SIZE IS "<<image.sizeInBytes();
            return image;

    }
    else
    {
        std::cout << fileType << " is unsupported." << std::endl;
    }

    return QImage();


}

void LiveImageProvider::updateImage(QImage image)
{
    if(this->image != image){
        qDebug()<<"che gandi zadi dobare bejesh";
        this->image = image;
        //        emit imageChanged();
    }
}
