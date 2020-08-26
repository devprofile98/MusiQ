#include "tools.h"

tools::tools()
{
    playerCounter = 0;
}

QString tools::getNowPlayList()
{
    if (nowPlayList.count()==0){
        return "null";
    }
    if (playerCounter>= nowPlayList.count())
    {
        playerCounter = 0;
        return nowPlayList.last();
    }
    else{

        QString temp = nowPlayList.at(playerCounter);
        playerCounter++;
        return temp;
    }


}

void tools::m_pauseRequested()
{
    emit pauseRequested();
}

void tools::setNowPlayList(QString path)
{
    nowPlayList.append(path);
}
