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
