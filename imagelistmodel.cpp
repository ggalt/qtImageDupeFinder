#include "imagelistmodel.h"

ImageListModel::ImageListModel(QObject *parent)
    : QAbstractItemModel(parent)
{
}

QModelIndex ImageListModel::index(int row, int column, const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

QModelIndex ImageListModel::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int ImageListModel::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int ImageListModel::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

bool ImageListModel::hasChildren(const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

bool ImageListModel::canFetchMore(const QModelIndex &parent) const
{
    // FIXME: Implement me!
    return false;
}

void ImageListModel::fetchMore(const QModelIndex &parent)
{
    // FIXME: Implement me!
}

QVariant ImageListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}

bool ImageListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ImageListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}
