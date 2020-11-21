#include "roundedrect.h"

RoundedRect::RoundedRect(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{

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
//    if (toprightRadius > width()/2 || toprightRadius > height()/2){
//        toprightRadius = height() >= width() ? width()/2 : height() /2;
//    }
    m_toprightRadius = toprightRadius*2;
    update();
}

void RoundedRect::setTopleftRadius(int topleftRadius)
{
//    if (topleftRadius > width()/2 || topleftRadius > height()/2){
//        topleftRadius = height() >= width() ? width()/2 : height() /2;
//    }
    m_topleftRadius = topleftRadius*2;
    update();
}

void RoundedRect::setBottomrightRadius(int bottomrightRadius)
{
//    if (bottomrightRadius > width()/2 || bottomrightRadius > height()/2){
//        bottomrightRadius = height() >= width() ? width()/2 : height() /2;
//    }
    m_bottomrightRadius = bottomrightRadius*2;
    update();
}

void RoundedRect::setBottomleftRadius(int bottomleftRadius)
{
//    if (bottomleftRadius > width()/2 || bottomleftRadius > height()/2){
//        bottomleftRadius = height() >= width() ? width()/2 : height() /2;
//    }
    m_bottomleftRadius = bottomleftRadius*2;
    update();
}

void RoundedRect::setColor(QString color)
{
    m_color = color;
    update();
}
bool RoundedRect::Antialiasing() const
{
    return m_Antialiasing;
}

void RoundedRect::setAntialiasing(bool Antialiasing)
{

    m_Antialiasing = Antialiasing;
    update();
}

void RoundedRect::paint(QPainter *painter)
{

    QPainterPath path;

    painter->setRenderHint(QPainter::Antialiasing,m_Antialiasing);

    path.moveTo(width(), m_toprightRadius/2);
    path.arcTo(width() - m_toprightRadius, 0, m_toprightRadius,m_toprightRadius,0.0,90.0);

    path.lineTo(m_topleftRadius/2,0);
    path.arcTo(0,0,m_topleftRadius,m_topleftRadius,90.0,90.0);

    path.lineTo(0,height()-m_bottomleftRadius/2);
    path.arcTo(0,height()-m_bottomleftRadius,m_bottomleftRadius,m_bottomleftRadius,180.0,90.0);

    path.lineTo(width()-m_bottomrightRadius/2,height());
    path.arcTo(width()-m_bottomrightRadius,height()-m_bottomrightRadius,m_bottomrightRadius,m_bottomrightRadius,270.0,90.0);
    path.moveTo(width(), height() - m_bottomrightRadius/2);
    path.closeSubpath();

    painter->setBrush(QColor(m_color)); // set background color from qml
    painter->setPen(QPen(QColor("transparent"), -1)); // border radius with size > 0 the result will not be pleasing
    painter->drawPath(path);
}
