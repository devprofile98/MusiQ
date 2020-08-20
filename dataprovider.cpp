#include "dataprovider.h"

DataProvider::DataProvider(QObject *parent) : QObject(parent)
{

    findMediaOnDisk();
    qDebug()<<"Class Constructed";

}

void DataProvider::extractSongInfo(qint64 id)
{

    TagLib::MPEG::File audiofile(all_path[0][id].toStdString().c_str());
    TagLib::ID3v2::Tag* tag = audiofile.ID3v2Tag(true);

    m_songTitle = QString::fromStdString(tag->title().toCString());
    m_songerName = QString::fromStdString(tag->artist().toCString());

    qDebug()<<"\n\n\n\n\n\n"<<m_songTitle<<" "<<m_songerName<<"\n\n\n";
    emit songTitleChanged();
    emit songerNameChanged();


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


QStringList* DataProvider::all_path = new QStringList();
QStringList DataProvider::search_filter("*.mp3");

