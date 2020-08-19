#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H

#include <QObject>
#include<QDebug>
#include<QStringList>
#include<QDir>
#include<QUrl>
#include <QStandardPaths>

#include<fileref.h>
#include<tag.h>
#include <mpeg/mpegfile.h>
#include <attachedpictureframe.h>
#include <mpeg/id3v2/id3v2tag.h>
#include <mp4/mp4file.h>
#include <mp4/mp4tag.h>
#include <mp4/mp4coverart.h>

#include<QDebug>
#include<QQmlContext>
#include<QString>
#include<QBuffer>
#include<QByteArray>
#include<QList>


class ImageFile : public TagLib::File
{
public:
    ImageFile(const char* file) : TagLib::File(file)
    {

    }

    TagLib::ByteVector data()
    {
        return readBlock(length());
    }


private:
    virtual TagLib::Tag* tag() const { return 0; }
    virtual TagLib::AudioProperties* audioProperties() const { return 0; }
    virtual bool save() { return false; }
};



class DataProvider : public QObject
{
    Q_OBJECT
public:
    explicit DataProvider(QObject *parent = nullptr);
    static QStringList* all_path;
    static QStringList search_filter;


private:

    void findMediaOnDisk();
    void songPathFinder(QDir current);

signals:


};

#endif // DATAPROVIDER_H
