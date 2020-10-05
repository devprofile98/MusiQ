#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H

#include <QObject>
#include<QDebug>
#include<QStringList>
#include<QDir>
#include<QUrl>
#include <QStandardPaths>
#include <QMutex>
#include <QMutexLocker>
#include <QImage>
#include <QVariant>

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


struct song{
    QString title;
    QString duration;
    QString artist;
};


class ImageFile : public TagLib::File
{
public:
    ImageFile(const char* file) : TagLib::File(file){}
    TagLib::ByteVector data() { return readBlock(length());}

private:
    virtual TagLib::Tag* tag() const { return 0; }
    virtual TagLib::AudioProperties* audioProperties() const { return 0; }
    virtual bool save() { return false; }
};


class DataProvider : public QObject {

    Q_OBJECT

public:
    Q_PROPERTY(QString songerName READ songerName NOTIFY songerNameChanged)
    Q_PROPERTY(QString songTitle READ songTitle NOTIFY songTitleChanged)
    Q_PROPERTY(int songReleaseYear READ songReleaseYear NOTIFY songReleaseYearChanged)
    Q_PROPERTY(QString songGenre READ songGenre NOTIFY songGenreChanged)
    Q_PROPERTY(QString albumName READ albumName NOTIFY albumNameChanged)

    explicit DataProvider(QObject *parent = nullptr);

    static QVariant get_id3v2_tag(qint64 id,uint request_type = 0);
    static QStringList* all_path;
    static QStringList search_filter;
    static uint REQUEST_IMAGE;
    static uint REQUEST_INFORMATION;

    Q_INVOKABLE static QVariant access_manager(qint64 id,uint request_type = 0);
    Q_INVOKABLE void extractSongInfo(qint64 id,uint request_type = 0);
    Q_INVOKABLE bool editSongInfo(int songid,QString singer_name, QString song_title, QString album_name,unsigned int release_year,QString genre);
//    QImage extractSongImage(qint64 id);

    QString songerName() const;
    QString songTitle() const;
    int songReleaseYear() const;
    QString songGenre() const;
    QString albumName() const;

private:

    void findMediaOnDisk();
    void songPathFinder(QDir current);
    static QMutex m_mutex;
    QString m_songerName;
    QString m_songTitle;
    int m_songReleaseYear;
    QString m_songGenre;
    QString m_albumName;

signals:

void songerNameChanged(QString song_name);
void songTitleChanged(QString song_title);
void songReleaseYearChanged(int song_release_year);
void songGenreChanged(QString song_genre);
void albumNameChanged(QString song_album_name);
};

#endif // DATAPROVIDER_H
