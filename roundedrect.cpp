#include "roundedrect.h"

RoundedRect::RoundedRect(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{

    qDebug()<<y() << "is the y";
}

int RoundedRect::toprightRadius() const
{
    return m_toprightRadius;
}

int RoundedRect::topleftRadius() const
{
    return m_topleftRadius;
}

int RoundedRect::bottomrightRadius() const
{
    return m_bottomrightRadius;
}

int RoundedRect::bottomleftRadius() const
{
    return m_bottomleftRadius;
}

QString RoundedRect::color() const
{
    return m_color;
}

void RoundedRect::setToprightRadius(int toprightRadius)
{
    update();
    m_toprightRadius = toprightRadius;
}

void RoundedRect::setTopleftRadius(int topleftRadius)
{
    update();
    m_topleftRadius = topleftRadius;
}

void RoundedRect::setBottomrightRadius(int bottomrightRadius)
{
    update();
    m_bottomrightRadius = bottomrightRadius;
}

void RoundedRect::setBottomleftRadius(int bottomleftRadius)
{
    update();
    m_bottomleftRadius = bottomleftRadius;
}

void RoundedRect::setColor(QString color)
{
    update();
    m_color = color;
}

void RoundedRect::paint(QPainter *painter)
{

    QPainterPath path;

    // top left curve begin
    path.moveTo(m_x, m_topleftRadius+m_y);
    path.arcTo(m_x , 0 + m_y , m_topleftRadius, m_topleftRadius,-180,-90);
    path.lineTo(width() + m_x - m_toprightRadius, 0+m_y);

    // top right curve
    path.arcTo(width() + m_x - m_toprightRadius, 0+m_y, m_toprightRadius, m_toprightRadius, 90, -90);
    path.lineTo(width()+m_x, height()+m_y - m_bottomrightRadius);

    //bottom right curve
    path.arcTo(width()+m_x, height(), -m_bottomrightRadius, -m_bottomrightRadius,180 ,-90);
    path.lineTo(m_x+m_bottomleftRadius, height()+m_y);

    //bottom left curve
    path.arcTo(m_x, height() , m_bottomleftRadius, -m_bottomleftRadius, -270,90);

    // go to beginig
    path.lineTo(m_x , 0   +m_y + m_topleftRadius);


    painter->setRenderHint(QPainter::Antialiasing);
    painter->setBrush(QColor(m_color)); // set background color from qml
    painter->setPen(QPen(QColor(m_color), 1)); // border radius
    painter->drawPath(path);
}
