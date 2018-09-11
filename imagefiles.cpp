#include <QDirIterator>
#include <QHashIterator>
#include <QSettings>
#include <QDebug>
#include <QDateTime>
#include <QStandardPaths>

#include "imagefiles.h"
#include "imageinfo.h"

imageFiles::imageFiles(QObject *parent) : QObject(parent)
{
    imagePointer = 0;

    qsrand(QDateTime::currentMSecsSinceEpoch());
//    qsrand(5);
}

imageFiles::~imageFiles()
{

}

QString imageFiles::nextImage()
{
    if( imagePointer == 0) {
        int randNum = qrand();
//        qDebug() << "Random number:" << randNum;
        imagesShown.insert(0, randNum % imageCount);
    } else {
        imagePointer--;
        if(imagePointer < 0)
            imagePointer = 0;
    }

    QString imageURL = "image://myImageProvider/"+photoUrlList.at(
                imagesShown.at(imagePointer));
//    qDebug() << imageURL << imagesShown;
    return imageURL;
}

QString imageFiles::previousImage()
{
    imagePointer+=2;    // NOT SURE WHY THIS NEEDS TO BE "PLUS 2" BUT IT WORKS
    if(imagePointer >= imagesShown.size())
        imagePointer = imagesShown.size()-1;

    QString imageURL = "image://myImageProvider/"+photoUrlList.at(
                imagesShown.at(imagePointer));
//    qDebug() << imageURL;
    return imageURL;
}

void imageFiles::ReadURLs()
{
    photoUrlList.clear();
    imageList.clear();

#ifdef Q_OS_LINUX
    //// Lenovo
    readImageURLsFromDisk(QDir("/home/ggalt/Pictures/"));

    //// Main
//    readImageURLsFromDisk(QDir("/home/ggalt/Pictures/"));

#else
    // Windows laptop
    readImageURLsFromDisk(QDir("C:/Users/ggalt66/Pictures/"));
    // Windows Desktop
//    readImageURLsFromDisk(QDir("C:/Users/George Galt/Pictures"));
#endif
    imageCount = photoUrlList.size();

}

void imageFiles::setupImageProvider(QQmlEngine *eng)
{
    imageProvider = new MyImageProvider(QQmlImageProviderBase::Image);
    eng->addImageProvider("myImageProvider", imageProvider);
}

void imageFiles::readImageURLsFromDisk(QDir d)
{
//    qDebug() << "Image URL:" << d;
    photoUrlList.clear();
    imageList.clear();
    QDirIterator it(d, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        it.next();
        if( it.fileInfo().isFile() ) {
            QString entry = it.fileInfo().absoluteFilePath();
            if( entry.contains(".JPG") || entry.contains(".jpg")) {
                imageInfo *p = new imageInfo();
                p->setImageFullPath(QDir(it.fileInfo().absoluteFilePath()));
                p->setImagePath(QDir(it.fileInfo().absoluteDir()));
                p->setImageFileName(it.fileInfo().fileName());

//                qDebug() << p->photoFileName() << "--" << p->photoPath() << "--" << p->photoFullPath();


                imageList.insert(p->imageFileNameNormalized(),p);
//                qDebug() << p->imageFileNameNormalized();
            }
        }
    }
    for( QMultiHash<QString, imageInfo*>::const_iterator hashIt = imageList.cbegin(), end = imageList.cend();
         hashIt != end; hashIt++ ) {
        qDebug() << hashIt.key() << hashIt.value();
    }
//    for (QHash<int, QString>::const_iterator it = hash.cbegin(), end = hash.cend(); it != end; ++it) {
//        cout << "The key: " << it.key() << endl
//        cout << "The value: " << it.value() << endl;
//        cout << "Also the value: " << (*it) << endl;
//    }
//    QHashIterator<QString, imageInfo*> hashIt(imageList);
//    while(hashIt.hasNext()) {
//        qDebug() << hashIt.value();
//    }
}
