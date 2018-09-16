#include <QDirIterator>
#include <QHashIterator>
#include <QSettings>
#include <QDebug>
#include <QDateTime>
#include <QStandardPaths>
#include <QList>
#include <QListIterator>
#include <QStringList>
#include <QMutableListIterator>

#include "imagefiles.h"
#include "imageinfo.h"

imageFiles::imageFiles(QObject *parent) : QObject(parent)
{
    m_imagePointer = 0;

    qsrand(QDateTime::currentMSecsSinceEpoch());
    //    qsrand(5);
}

imageFiles::imageFiles( const imageFiles &i ) : QObject(i.parent())
{
    setImageList( i.imageList() );
    setImageNameList( i.imageNameList() );
    setImageCount( i.imageCount() );
    setImagePointer( i.imagePointer() );
    setTopDir( i.topDir() );
}

imageFiles::~imageFiles()
{

}

QString imageFiles::nextImageName()
{
    //    QString imageURL = "image://myImageProvider/"+photoUrlList.at(
    //                imagesShown.at(imagePointer));
    //    return imageURL;
    if(m_imagePointer >= m_imageNameList.count())
        return QString();
    else {
        //        qDebug() << "imagepointer:" << imagePointer;
        return m_imageNameList.at(m_imagePointer++);
    }
}

QString imageFiles::previousImageName()
{
    //    QString imageURL = "image://myImageProvider/"+photoUrlList.at(
    //                imagesShown.at(imagePointer));
    //    return imageURL;
    if( m_imagePointer <= 0 )
        return QString();
    else {
        //        qDebug() << "imagepointer:" << imagePointer;
        return m_imageNameList.at(m_imagePointer--);
    }
}

void imageFiles::ReadURLs()
{
    m_imageList.clear();

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
}

void imageFiles::setupImageProvider(QQmlEngine *eng)
{
    imageProvider = new MyImageProvider(QQmlImageProviderBase::Image);
    eng->addImageProvider("myImageProvider", imageProvider);
}

void imageFiles::readImageURLsFromDisk(QDir d)
{
    m_imageList.clear();
    QDirIterator it(d, QDirIterator::Subdirectories);
    qDebug() << "Reading files from:" << d.absolutePath();
    while (it.hasNext()) {
        it.next();
        if( it.fileInfo().isFile() ) {
            QString entry = it.fileInfo().absoluteFilePath();
            if( entry.contains(".JPG") || entry.contains(".jpg")) {
                imageInfo *p = new imageInfo();
                p->setImageFullPath(QDir(it.fileInfo().absoluteFilePath()));
                p->setImagePath(QDir(it.fileInfo().absoluteDir()));
                p->setImageFileName(it.fileInfo().fileName());

                if(!m_imageList.contains(p->imageFileNameNormalized())) {
                    QList<imageInfo*> *newList = new QList<imageInfo*>;
                    m_imageList.insert(p->imageFileNameNormalized(),newList);
                    m_imageNameList.append(p->imageFileNameNormalized());
                }

                m_imageList.value(p->imageFileNameNormalized())->append(p);
            }
        }
    }

    // remove lines with only a single image (obviously no dupes)
    QMutableListIterator<QString> strIt(m_imageNameList);
    while (strIt.hasNext()) {
        QString myKey = strIt.next();
        if(m_imageList.value(myKey)->count() <= 1) {
            m_imageList.remove(myKey);
            strIt.remove();
            qDebug() << myKey;
        }

    }

//    QHashIterator<QString, QList<imageInfo*>*> hashIt(m_imageList);
//    while(hashIt.hasNext()){
//        QString myKey = hashIt.next().key();
//        QList<imageInfo*> *localList = m_imageList.value(myKey);
//        qDebug() << myKey << localList->count();
//        if(localList->count() > 1) {
//            QListIterator<imageInfo*> listIt(*localList);
//            while(listIt.hasNext()) {
//                qDebug() << "\t" << listIt.next()->imageFullPath();
//            }
//        }
//    }
}

Q_DECLARE_METATYPE(imageFiles)
