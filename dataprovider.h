#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H

#include <QObject>
#include<QDebug>
#include<QStringList>
#include<QDir>
#include<QUrl>
#include <QStandardPaths>


class DataProvider : public QObject
{
    Q_OBJECT
public:
    explicit DataProvider(QObject *parent = nullptr);
    static QStringList* all_path;
    static QStringList search_filter;



private:

    void findMediaOnDisk();
    void songPathFinder(QDir current);

signals:


};

#endif // DATAPROVIDER_H
