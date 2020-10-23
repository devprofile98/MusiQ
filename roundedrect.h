#ifndef ROUNDEDRECT_H
#define ROUNDEDRECT_H

#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QPen>
#include <QPainter>
#include <QPainterPath>
#include <QString>

class RoundedRect: public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(int toprightRadius READ toprightRadius WRITE setToprightRadius)
    Q_PROPERTY(int topleftRadius READ topleftRadius WRITE setTopleftRadius)
    Q_PROPERTY(int bottomrightRadius READ bottomrightRadius WRITE setBottomrightRadius)
    Q_PROPERTY(int bottomleftRadius READ bottomleftRadius WRITE setBottomleftRadius)
    Q_PROPERTY(int xx READ xx WRITE setX)
    Q_PROPERTY(int yy READ yy WRITE setY)
    Q_PROPERTY(bool Antialiasing READ Antialiasing WRITE setAntialiasing)
//    Q_PROPERTY(int y1 READ y1 WRITE setY1)
//    Q_PROPERTY(int y2 READ y2 WRITE setY2)

    Q_PROPERTY(QString color READ color WRITE setColor)

//    Q_PROPERTY(int width READ width WRITE setWidth)
//    Q_PROPERTY(int height READ y2 WRITE setY2)



    int m_toprightRadius=0;

    int m_topleftRadius=0;

    int m_bottomrightRadius=0;

    int m_bottomleftRadius=0;

    int m_x=0;

    int m_y=0;

//    int m_y1=0;

//    int m_y2=0;


    QString m_color = "white";

    bool m_Antialiasing = true;

public:
    RoundedRect(QQuickItem *parent=0);
    void paint(QPainter *painter);


    int toprightRadius() const;
    int topleftRadius() const;

    int bottomrightRadius() const;

    int bottomleftRadius() const;

    int xx() const
    {
        qDebug()<<"x is "<<m_x;
        return m_x;
    }

    int yy() const
    {
        return m_y;
    }

//    int y1() const
//    {
//        return m_y1;
//    }

//    int y2() const
//    {
//        return m_y2;
//    }

    QString color() const;

    bool Antialiasing() const;

public slots:
    void setToprightRadius(int toprightRadius);
    void setTopleftRadius(int topleftRadius);
    void setBottomrightRadius(int bottomrightRadius);
    void setBottomleftRadius(int bottomleftRadius);
    void setColor(QString color);
//    void setX(int x)
//    {
//        m_x = x;
//        update();
//    }
//    void setY(int y)
//    {
//        m_y = y;
//        setWidth(1000);
//        qDebug()<< "the width is " << 200;
//        update();

//    }
//    void setY1(int y1)
//    {
//        m_y1 = y1;
//        update();

//    }
//    void setY2(int y2)
//    {
//        m_y2 = y2;
//        update();

    //    }
    void setAntialiasing(bool Antialiasing);
};


#endif // ROUNDEDRECT_H
