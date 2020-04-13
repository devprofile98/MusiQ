#ifndef LIVEIMAGEPROVIDER_H
#define LIVEIMAGEPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>
#include <QtDebug>
#include<QFileInfo>
#include<QtMultimedia>

class LiveImageProvider : public QObject , public QQuickImageProvider
{
    Q_OBJECT
public:
    explicit LiveImageProvider(QObject *parent = nullptr);
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

public slots:
    void updateImage(QImage image);
    static void trytosolve(){qDebug()<<"injaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam";};

signals:
    void imageChanged();



private:
    QImage image;
    QImage default_image;
    QMediaPlayer music;

};

#endif // LIVEIMAGEPROVIDER_H
