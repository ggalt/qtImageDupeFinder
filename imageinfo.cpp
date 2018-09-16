#include "imageinfo.h"

imageInfo::imageInfo(QObject *parent):QObject(parent)
{
    m_willBeDeleted = false;
}

imageInfo::imageInfo( const imageInfo &i):QObject(i.parent())
{
    setImageFileName(i.imageFileName());
    setImageFileNameNormalized(i.imageFileNameNormalized());
    setImageFullPath(i.imageFullPath());
    setImagePath(i.imagePath());
    setWillBeDeleted(i.willBeDeleted());
}

