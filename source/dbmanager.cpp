#include "dbmanager.h"
#include <QDebug>

DBManager::DBManager(const QString& path)
{

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(path);

    if(!m_db.open()){
        qDebug()<<"DATABASE:: cannot open the data base";
    }
    else{
        qDebug()<<"DATABASE:: data base opened succefully";

        QSqlQuery query;

        // create playlist table if doesnt exist
        if(!query.exec("create table playlist ("
                       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                       "name varchar(60),"
                       "count integer)"))
        {
            qDebug() << "DATABASE::ERROR::QUERY:: addPerson error:"<< query.lastError();
        }

        if(!query.exec("create table playlist_song (id int primary key, "
                       "path varchar(256),"
                       "belong INT,"
                       " FOREIGN KEY(belong) REFERENCES playlist(id))"))
        {
            qDebug() << "DATABASE::ERROR::QUERY:: addPerson error:"<< query.lastError();
        }

        if(!query.exec("create table liked_song (id int primary key, "
                       "path varchar(512))"
                       ))
        {
            qDebug() << "DATABASE::ERROR::QUERY:: like table creating error:"<< query.lastError();
        }

        if(!query.exec("create table song (id int primary key, "
                       "path varchar(512),"
                       "plays INTEGER,"
                       "liked INTEGER"
                       ")"
                       ))
        {
            qDebug() << "DATABASE::ERROR::QUERY:: like table creating error:"<< query.lastError();
        }
    }
}

void DBManager::addToPlaylist(QString path)
{
    QSqlQuery query;
}

void DBManager::creatPlaylist(QString name)
{
    QSqlQuery query;
    query.prepare("INSERT INTO playlist (name, count) VALUES (:name, :count)");
    query.bindValue(":name",name);
    query.bindValue(":count",0);
    if(!query.exec()){
        qDebug()<<"DATABASE::ERROR::INSERT:: cannot create new playlist\n"<<query.lastError();
    }
}

void DBManager::likeAsong(QString path)
{

    QSqlQuery query;
    query.prepare("INSERT INTO liked_song (path) VALUES (:path)");
    query.bindValue(":path", path);
    if(!query.exec()){
        qDebug() << "DATABASE::LIKE::ERROR -> CAN'T LIKE NEW SONG ";
    }


}

void DBManager::AddSongListToDB(const QStringList &songs)
{
    QSqlQuery query;

    query.prepare("INSERT INTO song (path) VALUES (?)");
    query.addBindValue(songs);

    if(!query.execBatch()){
        qDebug() << "Failed to load song path in database";
    }

}

QSharedPointer<QStringList> DBManager::GetSongListFromDB()
{
    QSqlQuery query("SELECT path from song");
    while(query.next()){
        songs->append(query.value(0).toString());
    }
    return songs;
}

bool DBManager::isEmpty()
{
    return songs->isEmpty();
}

QSharedPointer<QStringList> DBManager::songs = QSharedPointer<QStringList>{new QStringList{}};
