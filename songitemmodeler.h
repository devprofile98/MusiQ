#ifndef SONGITEMMODELER_H
#define SONGITEMMODELER_H

#include <QAbstractListModel>
#include<QDir>
#include <QStandardPaths>
#include<QtMultimedia>
#include <QDebug>
#include "tools.h"
#include "dataprovider.h"


class LiveImageProvider;

//class backend2;
class songitemmodeler : public QAbstractListModel
{
    Q_OBJECT
    //    Q_PROPERTY(backend2 *list READ list WRITE setList )
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)
    Q_PROPERTY(int duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(qint64 passed READ passed NOTIFY passedChanged)
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


public slots:
    void m_setPosition(qint64 value);
    void m_ChangePlaybackMode(int mode);


signals:
    void progressChanged();
    void durationChanged();

    void passedChanged();

public:

    explicit songitemmodeler(QObject *parent = nullptr,tools *tool = nullptr);
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int,QByteArray> roleNames() const override;

    int duration() const
    {
        return m_duration;
    }

    qint64 passed() const
    {
        return m_passed;
    }

private:
    qint64 findSongDuration(QString path) const;
    QVariant findImageSource(QString path) const;
    void songpathfinder(QDir home,QStringList filters,QStringList& allpath);
    //    backend2 *bend;
    QStringList allPath;
    QStringList searchfilters;
    mutable int m_index;
    QMediaPlayer m_playing_song;
    QMediaPlaylist m_playlist;
    int m_current_position;
    QUrl pic;
    tools tool;

    LiveImageProvider* newclassmember;

    int m_duration = 0;
    qint64 m_passed = 0;
};

#endif // SONGITEMMODELER_H
