#ifndef TOOLS_H
#define TOOLS_H

#include <QObject>

class tools:public QObject
{
  Q_OBJECT
public:
    tools();
    Q_INVOKABLE void setNowPlayList(QString path);
    Q_INVOKABLE QString getNowPlayList();

    
private:
    QStringList nowPlayList;
    int playerCounter;
};

#endif // TOOLS_H
