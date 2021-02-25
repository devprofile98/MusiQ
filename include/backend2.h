#ifndef BACKEND2_H
#define BACKEND2_H

#include <QObject>
#include <QVector>
#include <QDir>



class backend2 : public QObject
{
    Q_OBJECT
public:
    explicit backend2(QObject *parent = nullptr);
    QVector<QString>  takeItems() const;
    QString itemAt(int index);

signals:

public slots:


private:
    void findItems(QDir home,QStringList searchFilter,QStringList& allSongPath);
    QVector<QString> m_items;
    QStringList searchFilter;
    QStringList allSongPath;
};

#endif // BACKEND2_H
