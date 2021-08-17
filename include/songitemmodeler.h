#ifndef SONGITEMMODELER_H
#define SONGITEMMODELER_H

#include <QAbstractListModel>
#include<QDir>
#include <QStandardPaths>
#include<QtMultimedia>
#include <QDebug>
#include <QList>

#include "tools.h"
#include "dataprovider.h"
#include "structures.h"
#include "dbmanager.h"

class LiveImageProvider;

enum {
    desc=0,
    pic,
};



//class backend2;
class songitemmodeler : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(qint64 progress READ progress NOTIFY progressChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(qint64 passed READ passed NOTIFY passedChanged)
    Q_PROPERTY(qint64 check NOTIFY songchanged)
    Q_PROPERTY(quint8 playbackmode READ playbackmode NOTIFY playbackmodeChanged)


public:
    Q_INVOKABLE QVariant ahmad();
    Q_INVOKABLE void play(QString path,int currentindex);
    Q_INVOKABLE void m_status();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void playIndex(); // play specific index
    Q_INVOKABLE int progress();
    Q_INVOKABLE void setProgress(int value);
    explicit songitemmodeler(QObject *parent = nullptr,tools *tool = nullptr);
    ~songitemmodeler();

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int,QByteArray> roleNames() const override;
    qint64 duration() const {return m_duration;}
    qint64 passed() const{return m_passed;}


    quint8 playbackmode() const
    {
        return m_playback_mode;
    }

public slots:
    void m_setPosition(qint64 value);
    void m_ChangePlaybackMode(int mode=-2);


signals:
    void progressChanged();
    void durationChanged(qint64 value);
    void passedChanged();
    void songchanged(qint64 index);
    void playbackmodeChanged(quint8 playbackmode);

private:
    qint64 findSongDuration(QString path) const;
    QVariant findImageSource(QString path) const;
    void songpathfinder(QDir home,QStringList filters,QStringList& allpath);
    QStringList allPath;
    QStringList searchfilters;
    QList<Song> m_songs;
    mutable int m_index;
    QMediaPlayer m_playing_song;
    QMediaPlaylist m_playlist;
    int m_current_position;
    tools tool;
    quint8 m_playback_mode;
    int m_duration = 0;
    qint64 m_passed = 0;
    qint64 m_check;
};

#endif // SONGITEMMODELER_H
