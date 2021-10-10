#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QString>
#include <QObject>
#include <QSharedDataPointer>

class DBManager:public QObject
{
    Q_OBJECT
public:
    DBManager(const QString& path);
    Q_INVOKABLE void addToPlaylist(QString path);
    Q_INVOKABLE void creatPlaylist(QString name);
    Q_INVOKABLE void likeAsong(QString path);

    static void AddSongListToDB(const QStringList& songs);
    static QSharedPointer<QStringList> GetSongListFromDB();
    static bool isEmpty();

private:
    QSqlDatabase m_db;
    static QSharedPointer<QStringList> songs;
};

#endif // DBMANAGER_H
