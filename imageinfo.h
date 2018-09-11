#ifndef IMAGEINFO_H
#define IMAGEINFO_H

#include <QObject>
#include <QString>
#include <QDir>


class imageInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imageFileName READ imageFileName WRITE setImageFileName)
    Q_PROPERTY(QString imageFileNameNormalized READ imageFileNameNormalized WRITE setImageFileNameNormalized)
    Q_PROPERTY(QDir imagePath READ imagePath WRITE setImagePath)
    Q_PROPERTY(QDir imageFullPath READ imageFullPath WRITE setImageFullPath)
    Q_PROPERTY(bool willBeDeleted READ willBeDeleted WRITE setWillBeDeleted)

public:
    explicit imageInfo(QObject *parent = nullptr);

    QString imageFileName() const { return m_imageFileName; }
    void setImageFileName( QString fname ) { m_imageFileName = fname; m_imageFileNameNormalized = fname.toUpper();}

    QString imageFileNameNormalized() const { return m_imageFileNameNormalized; }
    void setImageFileNameNormalized( QString fname ) { m_imageFileNameNormalized = fname; }

    QDir imagePath() const { return m_imagePath; }
    void setImagePath(QDir d) { m_imagePath = d; }

    QDir imageFullPath() const { return m_imageFullPath; }
    void setImageFullPath(QDir d) { m_imageFullPath = d; }

    bool willBeDeleted() const { return m_willBeDeleted; }
    void setWillBeDeleted(bool val) { m_willBeDeleted = val; }

signals:

public slots:

private:
    QDir m_imagePath;
    QDir m_imageFullPath;
    QString m_imageFileName;
    QString m_imageFileNameNormalized;
    bool m_willBeDeleted;
};

#endif // IMAGEINFO_H
