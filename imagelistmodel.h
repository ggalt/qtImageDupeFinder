#ifndef IMAGELISTMODEL_H
#define IMAGELISTMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QStringList>
#include <QHash>
#include <QByteArray>
#include "imagefiles.h"

class ImageListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(imageFiles* myImageFiles READ myImageFiles WRITE setMyImageFiles NOTIFY myImageFilesChanged)
    Q_PROPERTY(int row READ row WRITE setRow)

    Q_PROPERTY(QString imageFileName READ imageFileName CONSTANT)
    Q_PROPERTY(int curImageListCount READ curImageListCount CONSTANT)
    Q_PROPERTY(QStringList imageNameList READ imageNameList CONSTANT)
    Q_PROPERTY(QHash<QString, QList<imageInfo*>*> imageList READ imageList CONSTANT)

public:
    ImageListModel(QObject *parent = nullptr);
    ImageListModel( const ImageListModel &otherModel );
    ~ImageListModel() {}

    enum imageListRoles {
        ImageRole = Qt::UserRole + 1,
        ImageCountRole,
        ImageNameRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // functionality for declaring metadata type
    QStringList imageNameList(void) const {return m_MyImageFiles->imageNameList();}
    QHash<QString, QList<imageInfo*>*> imageList(void) const {return m_MyImageFiles->imageList();}
    imageFiles* myImageFiles(void) const {return m_MyImageFiles;}

    void setMyImageFiles(imageFiles *mf) { m_MyImageFiles = mf;}

    QString imageFileName(void) { return data(this->index(m_row),ImageNameRole).toString(); }
    int curImageListCount(void) { return data(this->index(m_row),ImageCountRole).toInt(); }


    int row(void) {return m_row;}
    void setRow(int r) {m_row=r;}

    Q_INVOKABLE QString getImageFileName(int r) { m_row = r; qDebug() << m_row; return imageFileName(); }
    Q_INVOKABLE int getCurImageListCount(int r) { m_row = r; return curImageListCount(); }
    Q_INVOKABLE QString getImage(int imageCount);
    Q_INVOKABLE QString getImageFileName(int row, int item);
    Q_INVOKABLE QString getImagePath(int row, int item);

signals:
    void imageNameListChanged(void);
    void imageListChanged(void);
    void myImageFilesChanged(void);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    imageFiles *m_MyImageFiles;
    int m_row;
};

Q_DECLARE_METATYPE(ImageListModel)

#endif // IMAGELISTMODEL_H
