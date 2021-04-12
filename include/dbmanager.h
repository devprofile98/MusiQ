#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include<QString>
#include <QObject>

class DBManager:public QObject
{
    Q_OBJECT
public:
    DBManager(const QString& path);
    Q_INVOKABLE void addToPlaylist(QString path);
    Q_INVOKABLE void creatPlaylist(QString name);
    Q_INVOKABLE void likeAsong(QString path);


private:
    QSqlDatabase m_db;
};

#endif // DBMANAGER_H
