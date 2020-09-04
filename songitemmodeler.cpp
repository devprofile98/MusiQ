#include "songitemmodeler.h"
#include<backend2.h>
#include<QtDebug>
#include<QMetaDataReaderControl>
#include "liveimageprovider.h"

songitemmodeler::songitemmodeler(QObject *parent,tools *tool)
    : QAbstractListModel(parent)
{
    m_index=0;
    searchfilters.append("*.mp3");
    allPath = *(DataProvider::all_path);

    for(int i =0;i<allPath.length();i++){

        m_playlist.addMedia(QUrl::fromLocalFile(allPath[i]));

    }

//    newclassmember->trytosolve();
    m_current_position = -1;
//    m_playlist.setCurrentIndex(0);
    m_playing_song.setPlaylist(&m_playlist);
    connect(tool,&tools::pauseRequested,this,[this](){
        m_playing_song.pause();
    });

    connect(&m_playlist,&QMediaPlaylist::currentIndexChanged,&m_playing_song,[this](){
//        dp->extractSongInfo(m_playlist.currentIndex());
//        emit dp->songTitleChanged();
        emit songchanged(m_playlist.currentIndex());
    });

    auto check_var = connect(&m_playing_song,&QMediaPlayer::mediaStatusChanged,&m_playing_song,[this](){
        if (m_playing_song.mediaStatus() == 6){
            m_duration = m_playing_song.duration();
            emit durationChanged(m_playing_song.duration());
        }
    });

    connect(&m_playing_song,&QMediaPlayer::positionChanged,[this](qint64 value){
        Q_UNUSED(this)
        m_passed = value;
        emit passedChanged();
    });


    m_playlist.setPlaybackMode(QMediaPlaylist::Sequential);

}

songitemmodeler::~songitemmodeler()
{
//    delete dp;

}


int songitemmodeler::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    
    if (parent.isValid())
        return m_playlist.mediaCount();
    
    return m_playlist.mediaCount();
}


QVariant songitemmodeler::data(const QModelIndex &index, int role) const
{
       
    m_index = index.row();
    
    
    
    if (!index.isValid())
        return QVariant();

    if (role ==0)
        return QVariant::fromValue(allPath.at(index.row()));
    
    else if (role==1)
        return QVariant(m_playing_song.duration());

    else if (role == 2){
        return QVariant(allPath.at(index.row()).split('/').last());
    }

    else if (role == 3){
        return  QVariant(allPath.at(index.row()));
    }
    else if (role == 4){
        if (m_current_position <0)
            return QVariant(false);
        else if (m_current_position == index.row()){
            return  QVariant(true);
        }
        else{
            return  QVariant(false);
        }
    }
    else if (role == 5){
        return QVariant();
    }
    else{
        return QVariant();
    }
    
    
}

bool songitemmodeler::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(value)
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
    Q_UNUSED(path)
    m_playlist.setCurrentIndex(currentindex);
    m_playing_song.play();


}

void songitemmodeler::m_status()
{
}

void songitemmodeler::next()
{
    m_playlist.next();
    m_playing_song.play();


}

void songitemmodeler::previous()
{
    m_playlist.previous();
    m_playing_song.play();

}

void songitemmodeler::pause()
{
    m_playing_song.pause();
}

void songitemmodeler::playIndex()
{
    m_playing_song.play();

}

int songitemmodeler::progress()
{
    return 100;
}

void songitemmodeler::setProgress(int value)
{
    Q_UNUSED(value)
    emit progressChanged();
}

void songitemmodeler::m_setPosition(qint64 value)
{
    m_playing_song.setPosition(value);
}

void songitemmodeler::m_ChangePlaybackMode(int mode)
{
    if (mode == 1){
        m_playlist.setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
    else if (mode == 0){
        m_playlist.setPlaybackMode(QMediaPlaylist::CurrentItemOnce);
    }
    else if (mode == 2){
        m_playlist.setPlaybackMode(QMediaPlaylist::Sequential);
    }
    else if (mode == 3){
        m_playlist.setPlaybackMode(QMediaPlaylist::Loop);
    }
    else if (mode == 4){
        m_playlist.setPlaybackMode(QMediaPlaylist::Random);
    }
}


qint64 songitemmodeler::findSongDuration(QString path) const
{
    QMediaPlayer song;
    song.setMedia(QUrl::fromLocalFile(path));
    //    connect(&song,&QMediaPlayer::mediaStatusChanged,this,&QMediaPlayer::media);
    //    QObject::connect(&song,&QMediaPlayer::stateChanged,[](){qDebug()<<"i am here";});
    return song.duration();
}



QVariant songitemmodeler::findImageSource(QString path) const
{
    QMediaPlayer song;
    song.setMedia(QUrl("file://"+path));
    return song.metaData(QMediaMetaData::MediaType);
}

