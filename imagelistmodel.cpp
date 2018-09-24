#include <QDebug>
#include "imagelistmodel.h"

ImageListModel::ImageListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

ImageListModel::ImageListModel( const ImageListModel &otherModel ) : QAbstractListModel(otherModel.parent())
{
    setMyImageFiles(otherModel.myImageFiles());
}


///
/// \brief ImageListModel::headerData
/// \param section
/// \param orientation
/// \param role
/// \return
///
//QVariant ImageListModel::headerData(int section, Qt::Orientation orientation, int role) const
//{
//    // FIXME: Implement me!
//}

///
/// \brief ImageListModel::rowCount
/// \param parent
/// \return
///
int ImageListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_MyImageFiles->imageNameList().count();
}

QVariant ImageListModel::data(const QModelIndex &index, int role) const
{
    qDebug() << index.isValid();
    if (!index.isValid())
        return QVariant();

    // if we're past the end of list of image names
    if( index.row() >= m_MyImageFiles->imageNameList().count() || index.row() < 0 )
        return QVariant();

    // get the list of images associated with this name
    const QList<imageInfo*> *imgList = m_MyImageFiles->imageList().value(m_MyImageFiles->imageNameList().at(index.row()));

    if( role == Qt::DisplayRole ) {
        return QVariant::fromValue(*imgList);
    } else if( role == ImageRole ) {
        return QVariant::fromValue(imgList->at(0)->imageFileName());
    } else if( role == ImageCountRole ) {
        qDebug() << imgList->count();
        return QVariant::fromValue(imgList->count());
    } else if( role == ImageNameRole ) {
        return QVariant::fromValue(imgList->at(0)->imageFileName());
    } else {
        return QVariant();
    }
}

QString ImageListModel::getImage(int imageCount)
{
    if(imageCount >= curImageListCount()) // oops, off the end
        return QString();

    // get the list of images associated with this name
    const QList<imageInfo*> *imgList = m_MyImageFiles->imageList().value(m_MyImageFiles->imageNameList().at(m_row));
    return imgList->at(imageCount)->imageFullPath().absolutePath();
}

QString ImageListModel::getImageFileName(int row, int item)
{
    QModelIndex idx = this->index(row);
    if( idx.row() >= m_MyImageFiles->imageNameList().count() || idx.row() < 0 )
        return QString();

    // get the list of images associated with this name
    const QList<imageInfo*> *imgList = m_MyImageFiles->imageList().value(m_MyImageFiles->imageNameList().at(idx.row()));

    if(item >= imgList->count())
        return QString();

    return imgList->at(item)->imageFileName();
}

QString ImageListModel::getImagePath(int row, int item)
{
    QModelIndex idx = this->index(row);
    if( idx.row() >= m_MyImageFiles->imageNameList().count() || idx.row() < 0 )
        return QString();

    // get the list of images associated with this name
    const QList<imageInfo*> *imgList = m_MyImageFiles->imageList().value(m_MyImageFiles->imageNameList().at(idx.row()));

    if(item >= imgList->count())
        return QString();

    return imgList->at(item)->imagePath().absolutePath();
}

QString ImageListModel::getImageSource(int row, int item) {
    qDebug() << "row:" << row << "Item:" << item;
    QModelIndex idx = this->index(row);
    if( idx.row() >= m_MyImageFiles->imageNameList().count() || idx.row() < 0 )
        return QString();

    // get the list of images associated with this name
    const QList<imageInfo*> *imgList = m_MyImageFiles->imageList().value(m_MyImageFiles->imageNameList().at(idx.row()));

    if(item >= imgList->count())
        return QString("qrc:/hole-2038431_640.png");

//    QString imageURL = "image://myImageProvider/"+imgList->at(item)->imageFullPath().absolutePath();
    QString imageURL = "file:///"+imgList->at(item)->imageFullPath().absolutePath();
    qDebug() << "Image URL:" << imageURL;
    return imageURL;
}

QHash<int, QByteArray> ImageListModel::roleNames() const {

    QHash<int, QByteArray> roles;

    roles[ImageRole] = "Image";
    roles[ImageCountRole] = "ImageCount";
    roles[ImageNameRole] = "ImageName";
    return roles;
}

