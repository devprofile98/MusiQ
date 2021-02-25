#ifndef TOOLS_H
#define TOOLS_H

#include <QObject>
#include <QDebug>

class tools:public QObject
{
  Q_OBJECT
public:
    tools();
    Q_INVOKABLE void setNowPlayList(QString path);
    Q_INVOKABLE QString getNowPlayList();
    Q_INVOKABLE void m_pauseRequested();
public slots:

signals:
    void nextMusicRequested();
    void musicIndexChanged(int index);
    void playRequested();
    void pauseRequested();
    void previousMusicRequested();

private:
    QStringList nowPlayList;
    int playerCounter;
};

#endif // TOOLS_H
