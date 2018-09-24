#include "myimageprovider.h"
#include <QImageReader>

MyImageProvider::MyImageProvider(QQmlImageProviderBase::ImageType type,
                                 QQmlImageProviderBase::Flags flags)
    : QQuickImageProvider(type,flags)
{

}

MyImageProvider::~MyImageProvider()
{

}
/*
QImage MyImageProvider::requestImage(const QString &id,
                                     QSize *size, const QSize &requestedSize)
{
//    qDebug() << "image id ==" << id;
    QImageReader *imgReader = new QImageReader(id);
    imgReader->setAutoTransform(true);
//    QImage initImage = imgReader->read().scaled(requestedSize, Qt::KeepAspectRatio);
    QImage initImage = imgReader->read();
    if(initImage.isNull()) {    // error in getting image
        qDebug() << "Image read error:" << imgReader->errorString();
        initImage = QImage(requestedSize,QImage::Format_ARGB32);
        initImage.fill(Qt::lightGray);
    }

//    QImage retVal;

//    if(requestedSize.isValid()) {
//        retVal = initImage.scaled(requestedSize, Qt::KeepAspectRatio);
//    } else {
//        retVal = initImage;
//    }
//    *size = retVal.size();
    *size = initImage.size();
    return initImage.scaled(requestedSize, Qt::KeepAspectRatio);
}
*/
QImage MyImageProvider::requestImage(const QString &id,
                                     QSize *size, const QSize &requestedSize)
{
    QImageReader *imgReader = new QImageReader(id);
    imgReader->setAutoTransform(true);
    QImage *retImage = new QImage(imgReader->read());

    if(retImage->isNull()) {    // error in getting image
        qDebug() << "Image read error:" << imgReader->errorString();
        retImage = new QImage(requestedSize,QImage::Format_ARGB32);
        retImage->fill(Qt::lightGray);
    }


    *size = retImage->size();

    QImage retVal;

    if(requestedSize.isValid())
       return (*retImage).scaled(QSize(200,200), Qt::KeepAspectRatio);
    else
        return (*retImage);
}

QPixmap MyImageProvider::requestPixmap(const QString &id,
                                       QSize *size, const QSize &requestedSize)
{
    QPixmap *initImage = new QPixmap(id);
    QPixmap retVal;

    if(requestedSize.isValid()) {
        retVal = initImage->scaled(requestedSize, Qt::KeepAspectRatio);
    } else {
        retVal = *initImage;
    }
    *size = retVal.size();
    return retVal;
}
