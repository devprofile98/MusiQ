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
    Q_PROPERTY(QString color READ color WRITE setColor)

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


    QString color() const;

    bool Antialiasing() const;



public slots:
    void setToprightRadius(int toprightRadius);
    void setTopleftRadius(int topleftRadius);
    void setBottomrightRadius(int bottomrightRadius);
    void setBottomleftRadius(int bottomleftRadius);
    void setColor(QString color);

    void setAntialiasing(bool Antialiasing);



signals:

private:

    int m_toprightRadius=0;

    int m_topleftRadius=0;

    int m_bottomrightRadius=0;

    int m_bottomleftRadius=0;

    int m_x=0;

    int m_y=0;

    QString m_color = "white";
    bool m_Antialiasing = true;

};


#endif // ROUNDEDRECT_H
