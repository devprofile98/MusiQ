#include "dataprovider.h"
#include<QThread>


QVariant DataProvider::get_id3v2_tag(qint64 id,uint request_type)
{
    if (request_type == DataProvider::REQUEST_INFORMATION){

        TagLib::MPEG::File audiofile(all_path[0][id].toStdString().c_str());

        if (!audiofile.hasID3v2Tag())
            return QStringList();

        TagLib::ID3v2::Tag* tag = audiofile.ID3v2Tag(true);

        QStringList info;
        info << tag->title().toCString()        // song title
             << tag->artist().toCString()       // song artist
             << QString::number(tag->year())    // song release year
             << tag->genre().toCString()        // song genre
             << tag->album().toCString();       // song album name

        if (!tag){
            return QStringList(); // invalid case
        }

        return info;  // valider than your mother milk
    }

    else if (request_type == DataProvider::REQUEST_IMAGE){
        QImage image;

        if (id >= DataProvider::all_path->size() || id < 0){
            return QImage();
        }

        TagLib::MPEG::File audioFile( DataProvider::all_path[0][id].toUtf8().toStdString().c_str());

        if (!audioFile.hasID3v2Tag())
            return QImage();

        TagLib::ID3v2::Tag* tag = audioFile.ID3v2Tag(true);
        TagLib::ID3v2::FrameList l = tag->frameList("APIC");

        if(l.isEmpty())
            return QImage();

        TagLib::ID3v2::AttachedPictureFrame *f =
                static_cast<TagLib::ID3v2::AttachedPictureFrame *>(l.front());

        image.loadFromData((const uchar *) f->picture().data(), f->picture().size());
        if (!image.isNull())
            return image;

        return QImage();
    }
    return QVariant();
}


QVariant DataProvider::access_manager(qint64 id, uint request_type)
{
    m_mutex.lock();    // lock mutex to manage access to file on disk

    if (request_type == DataProvider::REQUEST_INFORMATION){
        QStringList data = DataProvider::get_id3v2_tag(id , request_type).value<QStringList>();
        m_mutex.unlock();
        return data;
    }
    else if (request_type == DataProvider::REQUEST_IMAGE ){
        QVariant data = DataProvider::get_id3v2_tag(id , request_type);
        m_mutex.unlock();
        return data;
    }
    else{
        m_mutex.unlock();
        return QVariant();
    }
}


DataProvider::DataProvider(QObject *parent) : QObject(parent)
{
    findMediaOnDisk();
}


void DataProvider::extractSongInfo(qint64 id,uint request_type)
{
    Q_UNUSED(request_type)
    QStringList data = DataProvider::access_manager(id,0).value<QStringList>();
    if (data.length() <5){
        return;
    }
    m_songTitle = QString::fromStdString(data[0].toStdString());
    m_songerName = QString::fromStdString(data[1].toStdString());
    m_songReleaseYear = data[2].toInt();
    m_songGenre = QString::fromStdString(data[3].toStdString());
    m_albumName = QString::fromStdString(data[4].toStdString());
    emit songTitleChanged(m_songTitle);
    emit songerNameChanged(m_songerName);
    emit songReleaseYearChanged(m_songReleaseYear);
    emit songGenreChanged(m_songGenre);
    emit albumNameChanged(m_albumName);
}


bool DataProvider::editSongInfo(int songid,QString singer_name, QString song_title, QString album_name,unsigned int release_year, QString genre)
{
    TagLib::MPEG::File audioFile( DataProvider::all_path[0][songid].toUtf8().toStdString().c_str());

    if (!audioFile.hasID3v2Tag())
        return false;

    TagLib::ID3v2::Tag* tag = audioFile.ID3v2Tag(true);
//    TagLib::ID3v2::FrameList l = tag->frameList("APIC");

    tag->setAlbum(album_name.toStdString());
    tag->setYear(release_year);
    tag->setGenre(genre.toStdString());
    tag->setTitle(song_title.toStdString());
    tag->setArtist(singer_name.toStdString());

    audioFile.save();
    return true;

}


void DataProvider::findMediaOnDisk()
{
    songPathFinder(QDir(QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0)));
}


void DataProvider::songPathFinder(QDir current)
{
    if (current.entryList(QDir::AllEntries | QDir::NoDotAndDotDot).count()!=0){
        QStringList dirs;
        current.setFilter(QDir::Dirs);
        dirs    = current.entryList(QDir::Dirs |QDir::NoDotAndDotDot);
        current.setFilter(QDir::Files);
        current.setNameFilters(search_filter);

        for(int i =0;i<current.entryList().size();i++){
            //            allSongPath.append(current.absolutePath()+"/"+current.entryList().at(i));
            all_path->append(QString::fromUtf8(QString(current.absolutePath()+"/"+current.entryList().at(i)).toStdString().c_str()));

        }

        for(int i =0;i<dirs.size();i++){
            QDir cur(current.absolutePath()+"/"+dirs[i]);
            songPathFinder(cur);
        }
        return;
    }
    else{
        return;
    }
}


QString DataProvider::songerName() const
{
    return m_songerName;
}

QString DataProvider::songTitle() const
{
    return m_songTitle;
}

int DataProvider::songReleaseYear() const
{
    return m_songReleaseYear;
}

QString DataProvider::songGenre() const
{
    return m_songGenre;
}

QString DataProvider::albumName() const
{
    return m_albumName;
}


QStringList* DataProvider::all_path = new QStringList();
QStringList DataProvider::search_filter("*.mp3");

QMutex DataProvider::m_mutex;

uint DataProvider::REQUEST_IMAGE = 1;
uint DataProvider::REQUEST_INFORMATION =0;
