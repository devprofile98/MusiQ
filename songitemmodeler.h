#ifndef SONGITEMMODELER_H
#define SONGITEMMODELER_H

#include <QAbstractListModel>
#include<QDir>
#include <QStandardPaths>
#include<QtMultimedia>
#include <QDebug>


//class backend2;
class songitemmodeler : public QAbstractListModel
{
    Q_OBJECT
    //    Q_PROPERTY(backend2 *list READ list WRITE setList )
public:
    Q_INVOKABLE QVariant ahmad();
    Q_INVOKABLE void play(QString path,int currentindex);
    Q_INVOKABLE void m_status();
    Q_INVOKABLE void next();


public:

    explicit songitemmodeler(QObject *parent = nullptr);
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
    QVariant pic;

};

#endif // SONGITEMMODELER_H
