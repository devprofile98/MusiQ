#include "dataprovider.h"

DataProvider::DataProvider(QObject *parent) : QObject(parent)
{
    findMediaOnDisk();
    qDebug()<<"Class Constructed";

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
            all_path->append(current.absolutePath()+"/"+current.entryList().at(i));
//            m_playlist.addMedia(QUrl::fromLocalFile(current.absolutePath()+"/"+current.entryList().at(i)));

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


QStringList* DataProvider::all_path = new QStringList();
QStringList DataProvider::search_filter("*.mp3");

