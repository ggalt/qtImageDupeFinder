#ifndef IMAGEFILES_H
#define IMAGEFILES_H

#include <QObject>
#include <QStringList>
#include <QList>
#include <QString>
#include <QDir>
#include <QUrl>
#include <QQmlEngine>
#include <QHash>
#include "imageinfo.h"


#include "myimageprovider.h"
#define IMAGE_BUF_SIZE 1024

class imageFiles : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QHash<QString, QList<imageInfo*>*> imageList READ imageList WRITE setImageList NOTIFY imageListChanged)
    Q_PROPERTY(QStringList imageNameList READ imageNameList WRITE setImageNameList NOTIFY imageNameListChanged)
    Q_PROPERTY(int imageCount READ imageCount WRITE setImageCount NOTIFY imageCountChanged)
    Q_PROPERTY(int imagePointer READ imagePointer WRITE setImagePointer NOTIFY imagePointerChanged)
    Q_PROPERTY(QDir topDir READ topDir WRITE setTopDir NOTIFY topDirChanged)

public:
    explicit imageFiles(QObject *parent = nullptr);
    imageFiles( const imageFiles &i );
    ~imageFiles(void);

    QHash<QString, QList<imageInfo*>*> imageList(void) const {return m_imageList;}
    QStringList imageNameList(void) const { return m_imageNameList; }
    int imageCount(void) const { return m_imageCount; }
    int imagePointer(void) const { return m_imagePointer; }
    QDir topDir(void) const { return m_topDir; }

    void setImageList( QHash<QString, QList<imageInfo*>*> h ) { m_imageList = h; }
    void setImageNameList( QStringList s ) { m_imageNameList = s; }
    void setImageCount( int c ) { m_imageCount = c; }
    void setImagePointer( int p ) { m_imagePointer = p; }
    void setTopDir( QDir d ) { m_topDir = d; }

    Q_INVOKABLE QString nextImageName(void);
    Q_INVOKABLE QString previousImageName(void);
    Q_INVOKABLE QStringList getImageNameList(void) {return m_imageNameList;}
    Q_INVOKABLE QHash<QString, QList<imageInfo*>*> getImageList(void) {return m_imageList;}

    void ReadURLs(void);
    void setupImageProvider(QQmlEngine *eng);
    void readImageURLsFromDisk(QDir d);

signals:
    void imageListChanged(void);
    void imageNameListChanged(void);
    void imageCountChanged(void);
    void imagePointerChanged(void);
    void topDirChanged(void);

public slots:

private:
    MyImageProvider *imageProvider;

    QHash<QString, QList<imageInfo*>*> m_imageList;
    QStringList m_imageNameList;
    int m_imageCount;
    int m_imagePointer;
    QDir m_topDir;
};

#endif // IMAGEFILES_H
