#include "backend2.h"
#include<QtDebug>

backend2::backend2(QObject *parent) : QObject(parent)
{
       searchFilter.append("*.mp3");
       findItems(QDir::home(),searchFilter,allSongPath);

}

QVector<QString> backend2::takeItems() const
{
    return m_items;
}

QString backend2::itemAt(int index)
{
    qDebug()<<"hi"<<"\n";

       return m_items.at(index);

}

void backend2::findItems(QDir current,QStringList searchFilter,QStringList& allSongPath)
{
    if (current.entryList(QDir::AllEntries | QDir::NoDotAndDotDot).count()!=0){
        QStringList dirs;
        current.setFilter(QDir::Dirs);
        dirs    = current.entryList(QDir::Dirs |QDir::NoDotAndDotDot);
        current.setFilter(QDir::Files);
        current.setNameFilters(searchFilter);

        for(int i =0;i<current.entryList().size();i++){
//              allSongPath.append(current.absolutePath()+"/"+current.entryList().at(i));
              m_items.append(current.entryList().at(i));

          }

        for(int i =0;i<dirs.size();i++){
            QDir cur(current.absolutePath()+"/"+dirs[i]);
            findItems(cur,searchFilter,allSongPath);
        }
        return;
    }
    else{
        return;
    }
}
