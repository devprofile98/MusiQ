#include "songitemmodeler.h"
#include<backend2.h>
#include<QtDebug>
#include<QMetaDataReaderControl>

songitemmodeler::songitemmodeler(QObject *parent,tools *tool)
    : QAbstractListModel(parent)
{
    m_index=0;
    searchfilters.append("*.mp3");
    //    qDebug()<<"i am here"<<QDir("/files").entryList();
//    songpathfinder(QDir::home(),searchfilters,allPath);
    songpathfinder(QDir(QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0)),searchfilters,allPath);

    m_current_position = -1;
    pic = QVariant();
    m_playlist.setCurrentIndex(0);
    m_playing_song.setPlaylist(&m_playlist);

    connect(tool,&tools::pauseRequested,this,[this](){
        qDebug()<<"pause requested";
        m_playing_song.pause();
    });

    //    connect(&m_playing_song,&QMediaPlayer::mediaStatusChanged,&m_playing_song,[this](){
    connect(&m_playlist,&QMediaPlaylist::currentIndexChanged,&m_playing_song,[this](){
        m_playing_song.play();
    });
    connect(&m_playing_song,&QMediaPlayer::mediaStatusChanged,&m_playing_song,[this](){
        m_playing_song.play();

    });
    m_playlist.setPlaybackMode(QMediaPlaylist::Loop);

}

int songitemmodeler::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    
    if (parent.isValid())
        return m_playlist.mediaCount();
    
    return m_playlist.mediaCount();
}

void songitemmodeler::songpathfinder(QDir current,QStringList searchFilter,QStringList& allSongPath)
{
    if (current.entryList(QDir::AllEntries | QDir::NoDotAndDotDot).count()!=0){
        QStringList dirs;
        current.setFilter(QDir::Dirs);
        dirs    = current.entryList(QDir::Dirs |QDir::NoDotAndDotDot);
        current.setFilter(QDir::Files);
        current.setNameFilters(searchFilter);
        
        for(int i =0;i<current.entryList().size();i++){
            allSongPath.append(current.absolutePath()+"/"+current.entryList().at(i));
            allPath.append(current.absolutePath()+"/"+current.entryList().at(i));
            m_playlist.addMedia(QUrl::fromLocalFile(current.absolutePath()+"/"+current.entryList().at(i)));
            
        }
        
        for(int i =0;i<dirs.size();i++){
            QDir cur(current.absolutePath()+"/"+dirs[i]);
            songpathfinder(cur,searchFilter,allSongPath);
        }
        return;
    }
    else{
        return;
    }
}


QVariant songitemmodeler::data(const QModelIndex &index, int role) const
{
    //    Q_UNUSED(role)
    
    
    m_index = index.row();
    
    
    
    if (!index.isValid())
        return QVariant();
    // FIXME: Implement me!
    if (role ==0)
        return QVariant::fromValue(allPath.at(index.row()));
    
    else if (role==1)
        return QVariant("red");

    else if (role == 2){
        return QVariant(allPath.at(index.row()).split('/').last());
    }

    else if (role == 3){
        return  QVariant(allPath.at(index.row()));
    }
    else if (role == 4){
        if (m_current_position <0)
            return QVariant();
        else if (m_current_position == index.row()){
            qDebug()<<"see this :"<<index.row()<<m_current_position;
            return  QVariant(true);
        }
        else{
            return  QVariant(false);
        }
    }
    else if (role == 5){
        return  QVariant(pic);
    }
    else{
        return QVariant();
    }
    
    
}

bool songitemmodeler::setData(const QModelIndex &index, const QVariant &value, int role)
{
//    qDebug()<<"from updating role"<<role;

//    if (data(index, role) != value) {
//        // FIXME: Implement me!
//        emit dataChanged(index, index, QVector<int>() << role);
//        return true;
//    }
    if (role == 4){
        int last_index = m_current_position;
        m_current_position = index.row();
        emit dataChanged(createIndex(last_index,0),createIndex(last_index,0),QVector<int>() << role);
        emit dataChanged(createIndex(m_current_position,0),createIndex(m_current_position,0),QVector<int>() << role);
        return true;
    }
    return false;
}


Qt::ItemFlags songitemmodeler::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    
    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> songitemmodeler::roleNames() const
{
    QHash<int,QByteArray> names;
    names[0] = "desc";
    names[1] = "duration";
    names[2] = "name";
    names[3] = "path";
    names[4] = "selected";
    names[5] = "pic_url";
    return names;
}

QVariant songitemmodeler::ahmad()
{
    int curr = m_index;
    m_index++;
    return allPath.at(curr);
}

void songitemmodeler::play(QString path,int currentindex)
{
//    m_playing_song.setMedia(QUrl::fromLocalFile(path));
//    m_playing_song.setVolume(100);
//    connect(&m_playing_song,&QMediaPlayer::mediaStatusChanged,&m_playing_song,[this](){
//        qDebug()<<"song played "<<m_playing_song.metaData("CoverArtImage");
//        pic = m_playing_song.metaData("CoverArtImage").Url;
//        emit dataChanged(createIndex(0,0),createIndex(2,0),QVector<int>() <<3<<4<<5);

//    });
//    m_playing_song.play();
//    qDebug()<<"played "<<m_playing_song.mediaStatus() ;
    m_playlist.setCurrentIndex(currentindex);
//    m_playing_song.setPlaylist(&m_playlist);
//    m_playing_song.play();

}

void songitemmodeler::m_status()
{
    qDebug()<<m_playing_song.mediaStatus();
}

void songitemmodeler::next()
{
    m_playlist.next();
}

void songitemmodeler::previous()
{
    m_playlist.previous();
    qDebug()<<"pause is not working";

}

void songitemmodeler::pause()
{
    qDebug()<<"pause is not working";
    m_playing_song.pause();
    qDebug()<<"pause is working";
}

qint64 songitemmodeler::findSongDuration(QString path) const
{
    QMediaPlayer song;
    song.setMedia(QUrl::fromLocalFile(path));
//    connect(&song,&QMediaPlayer::mediaStatusChanged,this,&QMediaPlayer::media);
    //    QObject::connect(&song,&QMediaPlayer::stateChanged,[](){qDebug()<<"i am here";});
    qDebug()<<"in cpp   "<<path;
    return song.duration();
}



QVariant songitemmodeler::findImageSource(QString path) const
{
    QMediaPlayer song;
    song.setMedia(QUrl("file://"+path));
    return song.metaData(QMediaMetaData::MediaType);
}

