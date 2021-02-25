#include "mostplayedlist.h"

MostPlayedList::MostPlayedList(QObject *parent)
    : QAbstractListModel(parent)
{

}

QVariant MostPlayedList::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(section)
    Q_UNUSED(orientation)
    Q_UNUSED(role)
    return QVariant();
    // FIXME: Implement me!
}

int MostPlayedList::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return 10;
}

QVariant MostPlayedList::data(const QModelIndex &index, int role) const
{
    m_index = index.row();

    if (!index.isValid())
        return QVariant();
    // FIXME: Implement me!
    if (role ==0)
        return QVariant();
    else if (role==1)
        return QVariant();
    else if (role == 2){
        return QVariant();    }

    else if (role == 3){
        return QVariant();    }
    else if (role == 4){
        return QVariant();
    }
    else if (role == 5){
        return QVariant();
    }
    else{
        return QVariant();
    }


}


bool MostPlayedList::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);

    endInsertRows();
    return false;
}

bool MostPlayedList::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return false;
}

QHash<int, QByteArray> MostPlayedList::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[0] = "desc";
    roles[1] = "duration";
    roles[2] = "name";
    roles[3] = "path";
    roles[4] = "selected";
    roles[5] = "pic_url";
    return roles;
}

quint64 MostPlayedList::m_index = 0;
