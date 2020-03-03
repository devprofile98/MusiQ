#ifndef SONGITEMMODELER_H
#define SONGITEMMODELER_H

#include <QAbstractListModel>
#include<QDir>
#include <QStandardPaths>
#include<QtMultimedia>
#include <QDebug>
#include "tools.h"


//class backend2;
class songitemmodeler : public QAbstractListModel
{
    Q_OBJECT
    //    Q_PROPERTY(backend2 *list READ list WRITE setList )
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)
public:
    Q_INVOKABLE QVariant ahmad();
    Q_INVOKABLE void play(QString path,int currentindex);
    Q_INVOKABLE void m_status();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void pause();
    Q_INVOKABLE int progress();
    Q_INVOKABLE void setProgress(int value);

signals:
    void progressChanged();


public:

    explicit songitemmodeler(QObject *parent = nullptr,tools *tool = nullptr);
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int,QByteArray> roleNames() const override;

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
    QImage pic;
    tools tool;


};

#endif // SONGITEMMODELER_H
