#ifndef MOSTPLAYEDLIST_H
#define MOSTPLAYEDLIST_H

#include <QAbstractListModel>
#include<QHash>
#include<QByteArray>


class MostPlayedList : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit MostPlayedList(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    // Remove data:
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    
    // role names
    virtual QHash<int,QByteArray> roleNames() const override;
    

private:
    static quint64 m_index;
};

#endif // MOSTPLAYEDLIST_H
