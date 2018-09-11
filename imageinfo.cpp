#include "imageinfo.h"

imageInfo::imageInfo(QObject *parent):QObject(parent)
{
    m_willBeDeleted = false;
}
