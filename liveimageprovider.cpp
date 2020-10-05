#include "liveimageprovider.h"


LiveImageProvider::LiveImageProvider(QObject *parent) : QObject(parent),QQuickImageProvider(QQuickImageProvider::Image)
{

    this->default_image = QImage(":/new/prefix1/thumbnail.svg");
    this->blockSignals(false);

}

QImage LiveImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{

//    if (id.toInt() >= DataProvider::all_path->size() || id.toInt() < 0){
//        return QImage();
//    }
//    QImage image;
//    TagLib::MPEG::File audioFile( DataProvider::all_path[0][id.toInt()].toUtf8().toStdString().c_str());
//    TagLib::ID3v2::Tag* tag = audioFile.ID3v2Tag(true);
////    TagLib::ID3v2::Tag* tag = DataProvider::get_id3v2_tag(id.toInt());
//    TagLib::ID3v2::FrameList l = tag->frameList("APIC");
//    if(l.isEmpty())
//        return QImage();

//    TagLib::ID3v2::AttachedPictureFrame *f =
//            static_cast<TagLib::ID3v2::AttachedPictureFrame *>(l.front());

//    image.loadFromData((const uchar *) f->picture().data(), f->picture().size());
//    image.scaled( requestedSize.width(), requestedSize.height(),Qt::KeepAspectRatio);
////    delete f;
//    if (!image.isNull())
//        return image;

//    return default_image;


    QVariant res = DataProvider::access_manager(id.toUInt(),1);
    QImage image = res.value<QImage>();

    image.scaled( requestedSize.width(), requestedSize.height(),Qt::KeepAspectRatio);


    return image;

}

void LiveImageProvider::updateImage(QImage image)
{
    if(this->image != image){
        this->image = image;
        //        emit imageChanged();
    }
}
